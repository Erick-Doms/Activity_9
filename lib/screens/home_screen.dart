import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Activity 9 System!'),
            const SizedBox(height: 24),
            AppButton(
              text: 'Open Report Form',
              onPressed: () => Navigator.pushNamed(context, '/report'),
            ),
          ],
        ),
      ),
    );
  }
}