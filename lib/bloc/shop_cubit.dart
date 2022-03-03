import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/network/cache_helper.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';
import 'package:shop_app_flutter/screens/categories.dart';
import 'package:shop_app_flutter/screens/favorites.dart';
import 'package:shop_app_flutter/screens/home.dart';
import 'package:shop_app_flutter/screens/login.dart';
import 'package:shop_app_flutter/screens/settings.dart';
import 'package:shop_app_flutter/shared/components.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;
  List<String> banners = [];

  List<BottomNavigationBarItem> botNavItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> botNavScreens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  changeBotNavIndex(int index) {
    botNavCurrentIndex = index;
    emit(ShopBotNavState());
    //load from api based on the selected bottom nav
    switch (index) {
      case 0:
        {
          getBanners();
          break;
        }

      case 1:
        {
          //todo
          break;
        }

      case 2:
        {
          //todo
          break;
        }
      case 3:
        {
          //todo
          break;
        }
    }
  }

  void logOut(BuildContext context) {
    CacheHelper.removeData(key: 'token').then((value) {
      navigateToAndFinish(context: context, screen: LoginScreen());
    });
  }

  void getBanners() {
    if (banners.isNotEmpty) return;

    DioHelper.getData(path: BANNERS).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      BannerModel bannerModel = BannerModel.fromJson(json.data);
      bannerModel.bannerDataModels.forEach((element) {
        banners.add(element.image);
      });
      emit(ShopBannersState());
    });
  }
}
