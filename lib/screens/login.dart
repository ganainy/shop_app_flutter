import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoply'),
      ),
      body: const Text('Login '),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
