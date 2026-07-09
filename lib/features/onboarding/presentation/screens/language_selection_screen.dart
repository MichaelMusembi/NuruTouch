import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/orientation'),
              child: const Text('English'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/orientation'),
              child: const Text('Kiswahili'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
