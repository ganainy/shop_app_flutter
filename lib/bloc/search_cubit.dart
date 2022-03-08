import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/models/search_model.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';
import 'package:shop_app_flutter/shared/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  List<SearchProductDataModel> products = [];

  static SearchCubit get(context) => BlocProvider.of(context);

  // Shared.favoriteProductsIds

  void search(String query) {
    emit(SearchLoading());
    products = [];
    DioHelper.postData(path: SEARCH, headers: {
      'Authorization': Shared.TOKEN
    }, data: {
      'text': query,
    }).then((json) {
      if (json.data['status']) {
        SearchProductsModel searchProductsModel =
            SearchProductsModel.fromJson(json.data);
        products = [];
        searchProductsModel.searchProductDataModels.forEach((element) {
          products.add(element);
        });
        emit(SearchSuccess());
      } else {
        emit(SearchError(json.data['message']));
      }
    }).catchError((error) {
      emit(SearchError(error.toString()));
    });
  }

  void addRemoveFavorite(SearchProductDataModel product, BuildContext context) {
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

  void updateFavoriteLists(SearchProductDataModel product) {
    if (Shared.favoriteProductsIds.contains(product.id)) {
      Shared.favoriteProductsIds.remove(product.id);
    } else {
      Shared.favoriteProductsIds.add(product.id);
    }

    emit(LocalChangeFavoriteState());
  }

  void resetSearch() {
    products = [];
    emit(SearchInitial());
  }
}
