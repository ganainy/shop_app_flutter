class BannerModel {
  late bool status;
  List<BannerDataModel> bannerDataModels = [];

  BannerModel.fromJson(json) {
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
