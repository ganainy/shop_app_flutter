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
  List<CategoriesDataModel> categories = [];
  List<ProductDataModel> categoryProducts = [];
  ProfileModel? profileModel;

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
    SettingsScreen(),
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
      Shared.TOKEN = '';
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
    print('favoriteProductsIds count ${Shared.favoriteProductsIds.length}');
    DioHelper.getData(
        path: PRODUCTS,
        queryParams: {'category_id': '$categoryId'}).then((json) {
      //print('getBanners${bannerModel.bannerDataModels[0].image}');
      ProductsModel categoryProductsModel = ProductsModel.fromJson(json.data);
      categoryProductsModel.productDataModels.forEach((element) {
        categoryProducts.add(element);
      });

      //print('getCategoryProducts${categoryProducts}');
      emit(ShopCategoryProductsSuccessState());
    });
  }

  getFavorites() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(path: FAVORITES, headers: {
      'Authorization': Shared.TOKEN,
    }).then((json) {
      print('getFavorites${json}');
      Shared.favoriteProductsIds = [];

      FavoriteProductsModel favoriteProductsModel =
          FavoriteProductsModel.fromJson(json.data);
      favoriteProductsModel.favoriteProductDataModel.forEach((element) {
        Shared.favoriteProductsIds.add(element.productId);
      });

      //print('getFavoriteProducts${favoriteProducts[0].name}');
      emit(ShopFavoritesSuccessState());
    });
  }

  void addRemoveFavorite(ProductDataModel product, BuildContext context) {
    print('addRemoveFavorite called ');

    //update locally to show on ui
    updateFavoriteLists(product);
    //update on the api
    DioHelper.postData(path: FAVORITES, headers: {
      'Authorization': Shared.TOKEN,
    }, data: {
      'product_id': product.id,
    }).then((json) {
      //update of favorite on api success

      FavoriteResponse response = FavoriteResponse.fromJson(json.data);
      if (!response.status) {
        //update of favorite on api failed,reverse the changes made to ui and show
        //error message
        updateFavoriteLists(product);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${product.name} favorite state update failed"),
        ));
      }
    }).catchError((error) {
      //update of favorite on api failed,reverse the changes made to ui and show
      //error message
      print('error ${error.toString()}');
      updateFavoriteLists(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${product.name} favorite state update failed"),
      ));
    });
  }

  void updateFavoriteLists(ProductDataModel product) {
    if (Shared.favoriteProductsIds.contains(product.id)) {
      Shared.favoriteProductsIds.remove(product.id);
    } else {
      Shared.favoriteProductsIds.add(product.id);
    }

    emit(LocalChangeFavoriteState());
  }

  getProfile() {
    if (profileModel != null) return;

    emit(ProfileGetLoading());
    DioHelper.getData(path: PROFILE, headers: {
      'Authorization': Shared.TOKEN,
    }).then((json) {
      profileModel = ProfileModel.fromJson(json.data);
      print('getProfile${profileModel?.profileDataModel.name}');

      emit(ProfileGetSuccess());
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  updateProfile(
      {required String name,
      required String email,
      required String phone,
      required BuildContext context}) {
    emit(ProfileUpdateLoading());
    DioHelper.putData(path: UPDATE_PROFILE, headers: {
      'Authorization': Shared.TOKEN,
    }, data: {
      "name": name,
      "phone": phone,
      "email": email
    }).then((json) {
      profileModel = ProfileModel.fromJson(json.data);
      print('updateProfile${profileModel?.profileDataModel.name}');
      if (profileModel!.status) {
        emit(ProfileUpdateSuccess());
      } else {
        emit(ProfileUpdateError());
        var snackBar = SnackBar(
            content:
                Text(profileModel!.message ?? 'Error while updating profile'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        print('profileModel!.message ${profileModel!.message}');
      }
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(ProfileUpdateError());
      var snackBar =
          const SnackBar(content: Text('Error while updating profile'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
