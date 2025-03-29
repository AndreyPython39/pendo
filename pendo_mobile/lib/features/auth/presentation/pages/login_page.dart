import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:pendo_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:pendo_mobile/shared/widgets/forms/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEmailLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_isEmailLogin) {
        context.read<AuthBloc>().add(
              LoginWithEmailEvent(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            );
      } else {
        context.read<AuthBloc>().add(
              LoginWithPhoneEvent(
                phone: _emailController.text,
                password: _passwordController.text,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    CustomTextField(
                      controller: _emailController,
                      label: _isEmailLogin ? 'Email' : 'Phone',
                      hint: _isEmailLogin ? 'Enter your email' : 'Enter your phone',
                      keyboardType: _isEmailLogin
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return _isEmailLogin
                              ? 'Please enter your email'
                              : 'Please enter your phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Login',
                      onPressed: _onLoginPressed,
                      isLoading: state is AuthLoading,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEmailLogin = !_isEmailLogin;
                          _emailController.clear();
                        });
                      },
                      child: Text(
                        _isEmailLogin
                            ? 'Login with Phone'
                            : 'Login with Email',
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.register);
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
