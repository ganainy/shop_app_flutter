import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/bloc/shop_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shopCubit = ShopCubit.get(context);
    return Column(children: [
      const SizedBox(
        height: 6,
      ),
      CarouselSlider(
        options: CarouselOptions(
          height: 120.0,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: shopCubit.banners.map((bannerUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(bannerUrl),
                  ));
            },
          );
        }).toList(),
      ),
    ]);
  }
}
