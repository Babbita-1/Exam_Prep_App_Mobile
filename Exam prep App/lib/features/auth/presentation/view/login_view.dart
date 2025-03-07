import 'package:exam_prep/features/auth/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/login/login_bloc.dart';
import 'register_view.dart';

//login view
class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'bista@gmail.com');
  final _passwordController = TextEditingController(text: '123456790');

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      // Navigate to DashboardView on success
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardView()),
                      );
                    } else if (!state.isLoading && !state.isSuccess) {
                      // Show error message if login fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid email or password')),
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/exam-logo.png',
                            height: 180.0,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'WELCOME!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.pink,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            key: const ValueKey('email'),
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            key: const ValueKey('password'),
                            controller: _passwordController,
                            obscureText: !state.isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(TogglePasswordVisibilityEvent());
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          _gap,
                          _gap,
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text.trim();
                                final password =
                                    _passwordController.text.trim();

                                context.read<LoginBloc>().add(
                                      LoginUserEvent(
                                        email: email,
                                        password: password,
                                        context: context,
                                        destination:
                                            DashboardView(), // Updated destination
                                      ),
                                    );
                              }
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Brand Bold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don’t have an account?'),
                              TextButton(
                                key: const ValueKey('registerButton'),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        NavigateRegisterScreenEvent(
                                          destination: RegisterView(),
                                          context: context,
                                        ),
                                      );
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Brand Bold',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
