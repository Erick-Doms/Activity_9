import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: AppButton(
          text: 'Go to Home Screen',
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
    );
  }
}