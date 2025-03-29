import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:pendo_mobile/shared/widgets/buttons/primary_button.dart';

class VerificationPage extends StatefulWidget {
  final bool isEmail;

  const VerificationPage({
    super.key,
    required this.isEmail,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onVerifyPressed() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete verification code'),
        ),
      );
      return;
    }

    if (widget.isEmail) {
      context.read<AuthBloc>().add(VerifyEmailEvent(code));
    } else {
      context.read<AuthBloc>().add(VerifyPhoneEvent(code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify ${widget.isEmail ? 'Email' : 'Phone'}'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is VerificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter Verification Code',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ve sent a verification code to your ${widget.isEmail ? 'email' : 'phone'}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  PrimaryButton(
                    text: 'Verify',
                    onPressed: _onVerifyPressed,
                    isLoading: state is AuthLoading,
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement resend code
                    },
                    child: const Text('Resend Code'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
