//Banners
class BannersModel {
  late bool status;
  List<BannerDataModel> bannerDataModels = [];

  BannersModel.fromJson(json) {
    status = json['status'];
    List<dynamic> data = json['data'];
    data.forEach((element) {
      bannerDataModels.add(BannerDataModel.fromJson(element));
    });
  }
}

class BannerDataModel {
  late int id;
  late String image;

  BannerDataModel.fromJson(json) {
    id = json['id'];
    image = json['image'];
  }
}

//Categories
class CategoriesModel {
  late bool status;
  List<CategoriesDataModel> categoriesDataModels = [];

  CategoriesModel.fromJson(json) {
    status = json['status'];
    var data = json['data']['data'];
    data.forEach((element) {
      categoriesDataModels.add(CategoriesDataModel.fromJson(element));
    });
  }
}

class CategoriesDataModel {
  late int categoryId;
  late String name;
  late String image;

  CategoriesDataModel.fromJson(json) {
    categoryId = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

//Products
class ProductsModel {
  late bool status;
  List<ProductDataModel> productDataModels = [];

  ProductsModel.fromJson(json) {
    status = json['status'];
    var data = json['data']['data'];
    data.forEach((element) {
      productDataModels.add(ProductDataModel.fromJson(element));
    });
  }
}

class ProductDataModel {
  late int id;
  late var price;
  late var oldPrice;
  late var discount;
  late String image;
  late String name;
  late String description;

  ProductDataModel.fromJson(json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

//Favorite Products
class FavoriteProductsModel {
  late bool status;
  List<FavoriteProductDataModel> favoriteProductDataModel = [];

  FavoriteProductsModel.fromJson(json) {
    status = json['status'];
    var data = json['data']['data'];
    //print(data);
    data.forEach((element) {
      favoriteProductDataModel.add(FavoriteProductDataModel.fromJson(element));
    });
  }
}

class FavoriteProductDataModel {
  late int outerId;
  late int productId;
  late var price;
  late var oldPrice;
  late var discount;
  late String image;
  late String name;
  String? description;

  FavoriteProductDataModel.fromJson(json) {
    //print(json['product']);
    outerId = json['id'];
    productId = json['product']['id'];
    price = json['product']['price'];
    oldPrice = json['product']['old_price'];
    discount = json['product']['discount'];
    image = json['product']['image'];
    name = json['product']['name'];
    description = json['product']['description'];
  }
}

//add remove favorite response
class FavoriteResponse {
  late bool status;
  late String message;

  FavoriteResponse.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }
}

//profile
class ProfileModel {
  late bool status;
  String? message;

  late ProfileDataModel profileDataModel;

  ProfileModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
    profileDataModel = ProfileDataModel.fromJson(json['data']);
  }
}

class ProfileDataModel {
  late int id;
  late String name;
  late String email;
  late String phone;

  ProfileDataModel.fromJson(json) {
    //print(json['product']);
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}
