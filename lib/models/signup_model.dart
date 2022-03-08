class SignupModel {
  late bool status;

  late String message;
  late SignupDataModel? data;

  SignupModel.fromJson(Map<String, dynamic> response) {
    status = response['status'];
    message = response['message'];
    data = response['data'] != null
        ? SignupDataModel.fromJson(response['data'])
        : null;
  }
}

class SignupDataModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  SignupDataModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }
}
