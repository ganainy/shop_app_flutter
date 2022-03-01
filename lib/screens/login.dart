import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/login_cubit.dart';
import 'package:shop_app_flutter/layouts/shop_layout.dart';
import 'package:shop_app_flutter/screens/sign_up.dart';
import 'package:shop_app_flutter/shared/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          print('Login state:$state');

          if (state is LoginSuccess) {
            navigateToAndFinish(context: context, screen: ShopLayout());
          } else if (state is LoginError) {
            var snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
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
                          'LOGIN ',
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
                              loginCubit.changePasswordVisibility();
                            },
                            icon: loginCubit.isPasswordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          obscureText: !loginCubit.isPasswordVisible,
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
                        loginCubit.state is LoginLoading
                            ? LoadingButton()
                            : DefaultButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginCubit.login(
                                        email: emailController.text,
                                        password: passwordController.text);
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
                                navigateTo(
                                    context: context, screen: SignupScreen());
                              },
                              child: const Text('Sign up'),
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
