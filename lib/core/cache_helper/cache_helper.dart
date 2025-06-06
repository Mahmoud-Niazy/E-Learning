import 'package:e_learning/core/utils/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences ;

  static init()async{
    sharedPreferences =await  SharedPreferences.getInstance();
  }

  static String? get token => getData(key: AppKeys.token);
  static String? get userId => getData(key: AppKeys.userId);
  static bool? get isAr => getData(key: AppKeys.isAr);
  static bool get isDarkMode => getData(key: AppKeys.isDarkMode) ?? true;


  static Future<bool>  saveData({
    required String key,
    required dynamic value ,
  })async{
    if(value is bool){
      return await  sharedPreferences.setBool(key, value);
    }
    if(value is String ){
      return await sharedPreferences.setString(key, value);
    }
    if(value is int){
      return await sharedPreferences.setInt(key, value);
    }

    return await  sharedPreferences.setDouble(key, value);
  }

  static getData({
    required String key ,
  }){
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({
    required String key ,
  })async{
    return await sharedPreferences.remove(key);
  }
}