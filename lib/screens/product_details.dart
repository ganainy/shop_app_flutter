import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/bloc/product_cubit.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/shared/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen(this.product, {Key? key}) : super(key: key);
  ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductCubit productCubit = ProductCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              //pass flag on pop to decide if favorites should be reloaded or not
              Navigator.pop(context, productCubit.isFavoritesChanged);
              return false;
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        product.images != null
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  height: 160.0,
                                  viewportFraction: .8,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 2),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                ),
                                items: product.images?.map((imageUrl) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.grey),
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(imageUrl),
                                          ));
                                    },
                                  );
                                }).toList(),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image(
                                  fit: BoxFit.fill,
                                  height: 150,
                                  image: NetworkImage(product.image),
                                ),
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  product.name,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.end,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300],
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                product.price < product.oldPrice
                                    ? Text(
                                        product.oldPrice.toString(),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey),
                                      )
                                    : const SizedBox(),
                                const Spacer(),
                                (() {
                                  /*if (shopCubit.state is ShopFavoritesLoadingState) {
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          )),
                                    );
                                  } else */
                                  if (Shared.favoriteProductsIds
                                      .contains(product.id)) {
                                    print('fav item${product.id}');
                                    return IconButton(
                                        onPressed: () {
                                          productCubit.addRemoveFavorite(
                                              product, context);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ));
                                  } else {
                                    return IconButton(
                                        onPressed: () {
                                          productCubit.addRemoveFavorite(
                                              product, context);
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
                        Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(children: [
                          ConstrainedBox(
                              constraints: productCubit.isDescriptionExpanded
                                  ? const BoxConstraints(
                                      minWidth: double.infinity)
                                  : const BoxConstraints(
                                      minWidth: double.infinity,
                                      maxHeight: 100.0),
                              child: Text(
                                product.description,
                                textAlign: TextAlign.end,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                          productCubit.isDescriptionExpanded
                              ? Container()
                              : TextButton(
                                  child: const Text('view more'),
                                  onPressed: () =>
                                      productCubit.expandShrinkDescription())
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
