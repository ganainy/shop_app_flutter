import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return Container(
          child: Center(
            child: Column(
              children: [
                Text('SettingsScreen'),
                TextButton(
                    onPressed: () {
                      shopCubit.logOut(context);
                    },
                    child: Text('Log out'))
              ],
            ),
          ),
        );
      },
    );
  }
}
