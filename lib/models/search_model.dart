//Products
class SearchProductsModel {
  late bool status;
  List<SearchProductDataModel> searchProductDataModels = [];

  SearchProductsModel.fromJson(json) {
    status = json['status'];
    var data = json['data']['data'];
    data.forEach((element) {
      searchProductDataModels.add(SearchProductDataModel.fromJson(element));
    });
  }
}

class SearchProductDataModel {
  late int id;
  var price;
  late String image;
  late String name;
  late String description;
  late List<dynamic> images;

  SearchProductDataModel.fromJson(json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    images = json['images'];
    description = json['description'];
  }
}
