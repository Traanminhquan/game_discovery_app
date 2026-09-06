import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final authProvider =
        context.read<AuthProvider>();

    await authProvider.register(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),

                const Icon(
                  Icons.person_add_alt_1,
                  size: 80,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Create Account',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Create an account to start discovering games',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 40),

                // EMAIL
                TextFormField(
                  controller:
                      emailController,
                  keyboardType:
                      TextInputType
                          .emailAddress,
                  textInputAction:
                      TextInputAction.next,
                  decoration:
                      InputDecoration(
                    labelText: 'Email',
                    hintText:
                        'example@email.com',
                    prefixIcon:
                        const Icon(
                      Icons.email_outlined,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value
                            .trim()
                            .isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value
                        .contains('@')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // PASSWORD
                TextFormField(
                  controller:
                      passwordController,
                  obscureText: true,
                  textInputAction:
                      TextInputAction.next,
                  decoration:
                      InputDecoration(
                    labelText: 'Password',
                    prefixIcon:
                        const Icon(
                      Icons.lock_outline,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // CONFIRM PASSWORD
                TextFormField(
                  controller:
                      confirmPasswordController,
                  obscureText: true,
                  textInputAction:
                      TextInputAction.done,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Confirm Password',
                    prefixIcon:
                        const Icon(
                      Icons.lock_reset,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value !=
                        passwordController
                            .text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    if (!authProvider
                        .isLoading) {
                      register();
                    }
                  },
                ),

                const SizedBox(height: 16),

                // FIREBASE ERROR
                if (authProvider
                        .errorMessage !=
                    null)
                  Container(
                    padding:
                        const EdgeInsets
                            .all(12),
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.red.shade50,
                      borderRadius:
                          BorderRadius
                              .circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Icon(
                          Icons
                              .error_outline,
                          color: Colors
                              .red.shade700,
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child: Text(
                            authProvider
                                .errorMessage!,
                            style:
                                TextStyle(
                              color: Colors
                                  .red
                                  .shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (authProvider
                        .errorMessage !=
                    null)
                  const SizedBox(
                    height: 16,
                  ),

                // REGISTER BUTTON
                SizedBox(
                  height: 50,
                  child:
                      ElevatedButton(
                    onPressed:
                        authProvider
                                .isLoading
                            ? null
                            : register,
                    child:
                        authProvider
                                .isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth:
                                      2,
                                ),
                              )
                            : const Text(
                                'Register',
                              ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    const Text(
                      'Already have an account?',
                    ),

                    TextButton(
                      onPressed: () {
                        context
                            .read<
                                AuthProvider>()
                            .clearError();

                        Navigator.pop(
                          context,
                        );
                      },
                      child:
                          const Text(
                        'Login',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}