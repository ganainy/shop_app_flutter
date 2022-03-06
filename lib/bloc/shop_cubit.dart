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
import 'package:shop_app_flutter/shared/constants.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;
  List<String> banners = [];
  List<ProductDataModel> products = [];
  List<ProductDataModel> userFavoriteProducts = [];
  List<CategoriesDataModel> categories = [];
  List<CategoryProductDataModel> categoryProducts = [];

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
          //todo
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
      TOKEN = '';
      navigateToAndFinish(context: context, screen: LoginScreen());
    });
  }

  void getBanners() {
    if (banners.isNotEmpty) return;

    emit(ShopBannersLoadingState());

    DioHelper.getData(path: BANNERS).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      BannersModel bannersModel = BannersModel.fromJson(json.data);
      bannersModel.bannerDataModels.forEach((element) {
        banners.add(element.image);
      });
      emit(ShopBannersSuccessState());
    });
  }

  void getProducts() {
    if (products.isNotEmpty) return;

    DioHelper.getData(path: PRODUCTS).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      ProductsModel productsModel = ProductsModel.fromJson(json.data);
      productsModel.productDataModels.forEach((element) {
        products.add(element);
      });
      //after getting all products get user favorite products
      getFavorites();
      //print('getProducts${products[0].name}');
      //emit(ShopProductsState());
    });
  }

  void getCategories() {
    if (categories.isNotEmpty) return;

    DioHelper.getData(path: CATEGORIES).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      CategoriesModel categoriesModel = CategoriesModel.fromJson(json.data);
      categoriesModel.categoriesDataModels.forEach((element) {
        categories.add(element);
      });
      //print('getCategories${categories[0].name}');
      emit(ShopCategoriesSuccessState());
    });
  }

  //get products in certain category
  void getCategoryProducts(int categoryId) {
    if (categoryProducts.isNotEmpty) return;

    DioHelper.getData(
        path: PRODUCTS,
        queryParams: {'category_id': '$categoryId'}).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      CategoryProductsModel categoryProductsModel =
          CategoryProductsModel.fromJson(json.data);
      categoryProductsModel.categoryProductDataModels.forEach((element) {
        categoryProducts.add(element);
      });
      //print('getCategoryProducts${categoryProducts}');
      emit(ShopCategoryProductsSuccessState());
    });
  }

  getFavorites() {
    emit(ShopFavoritesLoadingState());
    //this list is only temporary to compare with products and add isFavorite to products
    List<FavoriteProductDataModel> favoriteProducts = [];

    DioHelper.getData(path: FAVORITES, headers: {
      'Authorization': TOKEN,
    }).then((json) {
      print('getFavorites${json}');

      FavoriteProductsModel favoriteProductsModel =
          FavoriteProductsModel.fromJson(json.data);
      favoriteProductsModel.favoriteProductDataModel.forEach((element) {
        favoriteProducts.add(element);
      });

      products.forEach((product) {
        for (var i = 0; i < favoriteProducts.length; i++) {
          if (product.id == favoriteProducts[i].productId) {
            product.isFavorite = true;
            if (!userFavoriteProducts.contains(product)) {
              userFavoriteProducts.add(product);
            }
          }
        }
      });

      //print('getFavoriteProducts${favoriteProducts[0].name}');
      emit(ShopFavoritesSuccessState());
    });
  }

  void addRemoveFavorite(ProductDataModel product, BuildContext context) {
    //update locally to show on ui
    updateFavoriteLists(product);
    //update on the api
    DioHelper.postData(path: FAVORITES, headers: {
      'Authorization': TOKEN,
    }, data: {
      'product_id': product.id,
    }).then((json) {
      //update of favorite on api success
    }).catchError((error) {
      //update of favorite on api failed,reverse the changes made to ui and show
      //error message
      updateFavoriteLists(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${product.name} favorite state update failed"),
      ));
    });
  }

  void updateFavoriteLists(ProductDataModel product) {
    if (userFavoriteProducts.contains(product)) {
      userFavoriteProducts.remove(product);
    } else {
      userFavoriteProducts.add(product);
    }
    products.forEach((element) {
      if (element == product) {
        element.isFavorite = !element.isFavorite;
      }
    });

    emit(LocalChangeFavoriteState());
  }
}
