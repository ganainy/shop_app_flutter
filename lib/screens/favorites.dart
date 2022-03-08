import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';
import 'package:shop_app_flutter/shared/constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return Container(
          child: Shared.favoriteProductsIds.isNotEmpty
              ? Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.grey[300],
                        height: 1,
                      );
                    },
                    itemCount: Shared.favoriteProductsIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FavoriteProduct(
                          shopCubit.products.firstWhere((product) =>
                              product.id == Shared.favoriteProductsIds[index]),
                          shopCubit,
                          context);
                    },
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
