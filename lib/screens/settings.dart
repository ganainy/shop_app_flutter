import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context)..getProfile();

        if (shopCubit.profileModel != null) {
          nameController.text = shopCubit.profileModel!.profileDataModel.name;
          emailController.text = shopCubit.profileModel!.profileDataModel.email;
          phoneController.text = shopCubit.profileModel!.profileDataModel.phone;
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              (shopCubit.state is ProfileUpdateLoading ||
                      shopCubit.state is ProfileGetLoading)
                  ? const LinearProgressIndicator()
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DefaultFormField(
                        controller: nameController,
                        labelText: '',
                        prefixIcon: const Icon(Icons.account_circle),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please enter name';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultFormField(
                        controller: emailController,
                        labelText: '',
                        prefixIcon: const Icon(Icons.email),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please enter email';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultFormField(
                        controller: phoneController,
                        labelText: '',
                        prefixIcon: const Icon(Icons.phone),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please enter phone';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultButton(
                        text: 'Update profile',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            shopCubit.updateProfile(
                                email: emailController.value.text,
                                name: nameController.value.text,
                                phone: phoneController.value.text,
                                context: context);
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultButton(
                        text: 'Sign out',
                        onPressed: () {
                          shopCubit.logOut(context);
                        }),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
