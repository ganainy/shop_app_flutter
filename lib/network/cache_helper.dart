import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<bool> setBool(
      {required String key, required bool value}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }
}
