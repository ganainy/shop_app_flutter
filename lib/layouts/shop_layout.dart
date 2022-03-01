import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var shopCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Shoply'),
            ),
            body: TextButton(
              onPressed: () {
                shopCubit.logOut(context);
              },
              child: Text('LOGOUT'),
            ),
          );
        },
      ),
    );
  }
}
