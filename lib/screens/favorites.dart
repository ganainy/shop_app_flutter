import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        var screenWidth = MediaQuery.of(context).size.width;
        return Container(
          child: shopCubit.userFavoriteProducts.isNotEmpty
              ? Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: .7,
                    crossAxisCount: 2,
                    children: List.generate(
                        shopCubit.userFavoriteProducts.length, (index) {
                      return Product(shopCubit.userFavoriteProducts[index],
                          screenWidth, shopCubit, context);
                    }),
                  ),
                )
              : const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'You don\'t have any favourite products',
                        style: TextStyle(fontSize: 24, fontFamily: 'Inter'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
