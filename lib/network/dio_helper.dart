import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    String path = 'v2/top-headlines',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParams,
    required Map<String, dynamic> data,
    String lang = 'en',
    String authorizationToken = '',
  }) async {
    //add headers to the dio in addition to the headers i alrady created in
    // case i want to pass some optional parameters like language
    dio.options.headers = {'lang': lang, 'Authorization': authorizationToken};

    return await dio.post(path, queryParameters: queryParams, data: data);
  }
}
