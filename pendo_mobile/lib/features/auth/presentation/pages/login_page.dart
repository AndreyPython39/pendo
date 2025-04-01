import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:pendo_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:pendo_mobile/shared/widgets/forms/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isCodeSent = false;
  bool _isResendEnabled = false;
  int _resendTimer = 60;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _onRequestCode() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            RequestCodeEvent(
              email: _emailController.text,
            ),
          );
      setState(() {
        _isCodeSent = true;
        _startResendTimer();
      });
    }
  }

  void _startResendTimer() {
    setState(() {
      _isResendEnabled = false;
      _resendTimer = 60;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  void _onVerifyCode() {
    if (_codeController.text.length == 6) {
      context.read<AuthBloc>().add(
            VerifyCodeEvent(
              email: _emailController.text,
              code: _codeController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, Routes.createProfile);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      // Logo
                      SvgPicture.asset(
                        'assets/images/pendo_logo.svg',
                        height: 80,
                      ),
                      const SizedBox(height: 48),
                      // Welcome Text
                      Text(
                        _isCodeSent ? 'Check your email' : 'Welcome to Pendo',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isCodeSent
                            ? 'Enter the 6-digit code we sent to'
                            : 'Enter your email to get started',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_isCodeSent) ...[
                        Text(
                          _emailController.text,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 48),
                      // Input Fields
                      if (!_isCodeSent)
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        )
                      else
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: PinCodeTextField(
                                appContext: context,
                                length: 6,
                                controller: _codeController,
                                onChanged: (_) {},
                                onCompleted: (_) => _onVerifyCode(),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: theme.colorScheme.surface,
                                  selectedFillColor: theme.colorScheme.surface,
                                  inactiveFillColor: theme.colorScheme.surface,
                                  activeColor: theme.colorScheme.primary,
                                  selectedColor: theme.colorScheme.primary,
                                  inactiveColor: theme.colorScheme.outline,
                                ),
                                keyboardType: TextInputType.number,
                                enableActiveFill: true,
                                animationType: AnimationType.scale,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                              onPressed: _isResendEnabled ? _onRequestCode : null,
                              child: Text(
                                _isResendEnabled
                                    ? 'Resend Code'
                                    : 'Resend code in ${_resendTimer}s',
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      // Action Button
                      if (!_isCodeSent)
                        PrimaryButton(
                          text: 'Continue with Email',
                          onPressed: _onRequestCode,
                          isLoading: state is AuthLoading,
                        ),
                      const SizedBox(height: 24),
                      // Social Login Options
                      if (!_isCodeSent) ...[
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'or continue with',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialButton(
                              icon: 'assets/icons/telegram.svg',
                              onPressed: () {
                                // TODO: Implement Telegram login
                              },
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 48),
                      // Terms and Privacy
                      if (!_isCodeSent)
                        Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
