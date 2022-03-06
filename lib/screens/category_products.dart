import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';

class CategoryProductsScreen extends StatelessWidget {
  CategoryProductsScreen(
    this.categoryId,
    this.categoryName, {
    Key? key,
  }) : super(key: key);

  int categoryId;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit shopCubit = ShopCubit.get(context)
            ..getCategoryProducts(categoryId);
          var screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            appBar: AppBar(title: (Text(categoryName))),
            body: shopCubit.categoryProducts.isNotEmpty
                ? Container(
                    color: Colors.grey[200],
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: .85,
                      crossAxisCount: 2,
                      children: List.generate(shopCubit.categoryProducts.length,
                          (index) {
                        //todo handle category product as product (unify models)
                        return Text('todo');
                      }),
                    ),
                  )
                : SizedBox(
                    child: Center(
                      child: FadingText('Loading...'),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
