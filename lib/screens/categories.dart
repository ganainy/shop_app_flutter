import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context)..getCategories();
        return shopCubit.categories.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Category(shopCubit.categories[index], context),
                    ),
                separatorBuilder: (context, index) => Container(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                itemCount: shopCubit.categories.length)
            : SizedBox(
                child: Center(
                  child: FadingText('Loading...'),
                ),
              );
      },
    );
  }
}
