import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app_flutter/bloc/search_cubit.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/models/search_model.dart';
import 'package:shop_app_flutter/screens/category_products.dart';
import 'package:shop_app_flutter/shared/constants.dart';

class PageViewModel {
  String title;
  String text;
  String image;

  PageViewModel(
    this.title,
    this.text,
    this.image,
  );
}

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return screen;
    }),
  );
}

DefaultFormField({
  required String labelText,
  required TextEditingController controller,
  bool obscureText = false,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  TextInputType? keyboardType,
  GestureTapCallback? onFieldTap,
  bool? isReadOnly,
  FormFieldValidator? validator,
  ValueChanged<String>? onFieldChanged,
  ValueChanged<String>? onFieldSubmitted,
}) {
  return TextFormField(
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onFieldChanged,
    onTap: onFieldTap,
    keyboardType: keyboardType,
    controller: controller,
    obscureText: obscureText,
    readOnly: isReadOnly ?? false,
    validator: validator,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: labelText,
    ),
  );
}

DefaultButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    child: Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(text.toUpperCase()),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    ),
  );
}

LoadingButton() {
  return Stack(children: [
    Container(
      height: 50,
      width: double.infinity,
      child: Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {},
          child: const Text(''),
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
    )
  ]);
}

Widget Category(CategoriesDataModel category, BuildContext context) {
  return GestureDetector(
    onTap: () => navigateTo(
        context: context,
        screen: CategoryProductsScreen(category.categoryId, category.name)),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            category.image,
            fit: BoxFit.fill,
            height: 100.0,
            width: 100.0,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: Text(
          category.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const Icon(
          Icons.arrow_forward_ios,
          color: primaryColor,
        )
      ],
    ),
  );
}

Widget Product(ProductDataModel product, double screenWidth,
    ShopCubit shopCubit, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              fit: BoxFit.fill,
              width: screenWidth / 2,
              height: 150,
              image: NetworkImage(product.image),
            ),
          ),
          product.price < product.oldPrice
              ? Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : SizedBox(),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.price.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                product.price < product.oldPrice
                    ? Text(
                        product.oldPrice.toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      )
                    : const SizedBox(),
                const Spacer(),
                (() {
                  if (shopCubit.state is ShopFavoritesLoadingState) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          )),
                    );
                  } else if (Shared.favoriteProductsIds.contains(product.id)) {
                    print('fav item${product.id}');
                    return IconButton(
                        onPressed: () {
                          shopCubit.addRemoveFavorite(product, context);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ));
                  } else {
                    return IconButton(
                        onPressed: () {
                          shopCubit.addRemoveFavorite(product, context);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ));
                  }
                }())
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget SearchProduct(SearchProductDataModel product, double screenWidth,
    SearchCubit searchCubit, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            fit: BoxFit.fill,
            width: screenWidth / 2,
            height: 150,
            image: NetworkImage(product.images.elementAt(0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.price.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Spacer(),
                (() {
                  if (Shared.favoriteProductsIds.contains(product.id)) {
                    print('fav item${product.id}');
                    return IconButton(
                        onPressed: () {
                          searchCubit.addRemoveFavorite(product, context);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ));
                  } else {
                    return IconButton(
                        onPressed: () {
                          searchCubit.addRemoveFavorite(product, context);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ));
                  }
                }())
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget FavoriteProduct(
    ProductDataModel product, ShopCubit shopCubit, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Row(
      children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              fit: BoxFit.fill,
              width: 120,
              height: 130,
              image: NetworkImage(product.image),
            ),
          ),
          product.price < product.oldPrice
              ? Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : SizedBox(),
        ]),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.price.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      product.price < product.oldPrice
                          ? Text(
                              product.oldPrice.toString(),
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      (() {
                        if (shopCubit.state is ShopFavoritesLoadingState) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                )),
                          );
                        } else if (Shared.favoriteProductsIds
                            .contains(product.id)) {
                          print('fav item${product.id}');
                          return IconButton(
                              onPressed: () {
                                shopCubit.addRemoveFavorite(product, context);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ));
                        } else {
                          return IconButton(
                              onPressed: () {
                                shopCubit.addRemoveFavorite(product, context);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              ));
                        }
                      }())
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void navigateToAndFinish(
    {required BuildContext context, required Widget screen}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  ), (r) => false);
}

Widget getPageViewItem(PageViewModel pageViewModel) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageViewModel.image),
        const SizedBox(
          height: 40,
        ),
        Text(
          pageViewModel.title,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: largeFontSize),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(pageViewModel.text,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: mediumFontSize)),
      ],
    ),
  );
}
