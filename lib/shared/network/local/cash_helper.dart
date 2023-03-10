import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences shared;
  static  init()async{
    shared= await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value
  })async{
    if(value is bool) return await shared.setBool(key, value);
    if(value is String) return await shared.setString(key, value);
    if(value is int) return await shared.setInt(key, value);
    return await shared.setDouble(key, value);

  }
  static dynamic getData(String key){
    return shared.get(key);

  }
  static Future<bool> removeData({required String key})
  async{
    return await shared.remove(key);
  }
}