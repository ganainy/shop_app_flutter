class LoginModel {
  late bool status;

  late String message;
  late LoginDataModel? data;

  //LoginModel(this.status, this.message, this.data);

  LoginModel.fromJson(Map<String, dynamic> response) {
    status = response['status'];
    message = response['message'];
    data = response['data'] != null
        ? LoginDataModel.fromJson(response['data'])
        : null;
  }
}

class LoginDataModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  LoginDataModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }
}
