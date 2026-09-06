import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
//import '../auth/login_screen.dart';

class ProfileScreen
    extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider =
        context.watch<AuthProvider>();

    final user =
        authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profile'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Email: ${user?.email ?? 'Unknown'}',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AuthProvider>()
                      .logout();
                },
                child:
                    const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}