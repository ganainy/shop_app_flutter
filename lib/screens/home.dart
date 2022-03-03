import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';
import 'package:shop_app_flutter/shared/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shopCubit = ShopCubit.get(context)
      ..getBanners()
      ..getProducts();
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(children: [
          const SizedBox(
            height: 6,
          ),
          shopCubit.banners.isNotEmpty
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 120.0,
                    viewportFraction: .95,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: shopCubit.banners.map((bannerUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(color: Colors.grey),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(bannerUrl),
                            ));
                      },
                    );
                  }).toList(),
                )
              : SizedBox(
                  height: 120,
                  child: Center(
                    child: FadingText('Loading...'),
                  ),
                ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: shopCubit.products.isNotEmpty
                ? Container(
                    color: Colors.grey[200],
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: .85,
                      crossAxisCount: 2,
                      children:
                          List.generate(shopCubit.products.length, (index) {
                        return Product(shopCubit.products[index], screenWidth);
                      }),
                    ),
                  )
                : SizedBox(
                    child: Center(
                      child: FadingText('Loading...'),
                    ),
                  ),
          ),
        ]);
      },
    );
  }
}
