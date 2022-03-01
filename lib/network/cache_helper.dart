import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  /*static Future<bool> setBool(
      {required String key, required bool value}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }*/

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else {
      throw Exception('this method only accepts bool,double,int or string');
    }
  }

  static Future<Object?> getData({required String key}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  static Future<bool?> removeData({required String key}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }
}
