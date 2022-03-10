import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';
import 'package:shop_app_flutter/shared/constants.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitial());

  bool isFavoritesChanged = false;
  bool isDescriptionExpanded = false;

  static ProductCubit get(context) => BlocProvider.of(context);

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
    //flag to update favorites if changed when navigating back to home
    isFavoritesChanged = true;
    if (Shared.favoriteProductsIds.contains(product.id)) {
      Shared.favoriteProductsIds.remove(product.id);
    } else {
      Shared.favoriteProductsIds.add(product.id);
    }

    emit(FavoriteUpdateState());
  }

  expandShrinkDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    emit(ExpandShrinkDescriptionState());
  }
}
