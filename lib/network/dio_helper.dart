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
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    if (headers != null) dio.options.headers = headers;
    return await dio.get(path, queryParameters: queryParams);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParams,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    //add headers to the dio in addition to the headers i alrady created in
    // case i want to pass some optional parameters like language
    dio.options.headers = headers;

    return await dio.post(path, queryParameters: queryParams, data: data);
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queryParams,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    //add headers to the dio in addition to the headers i alrady created in
    // case i want to pass some optional parameters like language
    dio.options.headers = headers;

    return await dio.put(path, queryParameters: queryParams, data: data);
  }
}
