import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/signup_cubit.dart';
import 'package:shop_app_flutter/layouts/shop_layout.dart';
import 'package:shop_app_flutter/screens/login.dart';
import 'package:shop_app_flutter/shared/components.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if (state is SignupError) {
            var snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is SignupSuccess) {
            navigateToAndFinish(context: context, screen: ShopLayout());
          }
        },
        builder: (context, state) {
          SignupCubit signupCubit = SignupCubit.get(context);
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER ',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 32),
                        ),
                        Text(
                          'Register to browse our offers ',
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
                              signupCubit.changePasswordVisibility();
                            },
                            icon: signupCubit.isPasswordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          obscureText: !signupCubit.isPasswordVisible,
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
                        DefaultFormField(
                          labelText: 'Name',
                          controller: nameController,
                          prefixIcon: const Icon(Icons.account_circle),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DefaultFormField(
                          labelText: 'Phone',
                          controller: phoneController,
                          prefixIcon: const Icon(Icons.phone),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter your phone';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        signupCubit.state is SignupLoading
                            ? LoadingButton()
                            : DefaultButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signupCubit.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                    );
                                  }
                                },
                                text: 'register'),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToAndFinish(
                                    context: context, screen: LoginScreen());
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
