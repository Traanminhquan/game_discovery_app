import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../home/home_screen.dart';

class RegisterScreen
    extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future<void> register() async {
    final authProvider =
        context.read<AuthProvider>();

    final success =
        await authProvider.register(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Register'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              decoration:
                  const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText: 'Password',
              ),
            ),

            const SizedBox(height: 24),

            if (authProvider.errorMessage !=
                null)
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Text(
                  authProvider.errorMessage!,
                ),
              ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    authProvider.isLoading
                        ? null
                        : register,
                child:
                    authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Register',
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}