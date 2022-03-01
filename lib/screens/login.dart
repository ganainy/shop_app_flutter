import 'package:flutter/material.dart';
import 'package:shop_app_flutter/screens/sign_up.dart';
import 'package:shop_app_flutter/shared/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login ',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 32),
              ),
              Text(
                'Login to browse our offers ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultFormField(
                labelText: 'Email address',
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter Email address';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultFormField(
                labelText: 'Password',
                controller: passwordController,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    isPasswordVisible = !isPasswordVisible;
                  },
                  icon: isPasswordVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter password';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid
                    }
                  },
                  text: 'login'),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                    onPressed: () {
                      navigateTo(context: context, screen: SignupScreen());
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
