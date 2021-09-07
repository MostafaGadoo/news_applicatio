import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init () async{
    sharedPreferences = await SharedPreferences.getInstance();

  }


   // ignore: missing_return
   static Future<bool> putBoolean ({
  @required String key,
    @required bool value,
    }) async{
     await sharedPreferences.setBool(key, value);

  }


  // ignore: missing_return
  static bool getBoolean ({
    @required String key,
  }) {
     sharedPreferences.getBool(key);

  }
}
