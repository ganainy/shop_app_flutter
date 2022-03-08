import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/screens/search.dart';
import 'package:shop_app_flutter/shared/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var shopCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Shoply',
                style: TextStyle(fontFamily: 'Merienda'),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context: context, screen: SearchScreen());
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 50,
              unselectedItemColor: Colors.grey,
              fixedColor: Colors.blue,
              items: shopCubit.botNavItems,
              currentIndex: shopCubit.botNavCurrentIndex,
              onTap: (index) => shopCubit.changeBotNavIndex(index),
            ),
            body: shopCubit.botNavScreens[shopCubit.botNavCurrentIndex],
          );
        },
      ),
    );
  }
}
