import 'package:dio/dio.dart';
class DioHelper{
  static late Dio dio;
  static init(){
    dio=Dio(
      BaseOptions(
        validateStatus: (status) => true,

        baseUrl:"https://student.valuxapps.com/api/",
    ));
  }
  static Future<Response> getData({
  required String url,
   Map<String,dynamic>? query,
    String token="",
    String lang="ar",
})async{

    dio.options.headers={
      "Content-Type":"application/json",

      "Authorization":token,
      "lang":lang,
    };

    return await dio.get(
      url,
      queryParameters: query,
    ).catchError((error){print(error.toString());});
  }

  static Future<Response> postData({
    required url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String? token,
    String lang="en",// optional
}){
    dio.options.headers={
      "Content-Type":"application/json",
      "Authorization":token,
      "lang":lang,

    };

    return dio.post(
        url,
        data: data,
        queryParameters: query,
    );
  }

  static Future<Response> putData({
    required url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String? token,
    String lang="ar",// optional
  }){
    dio.options.headers={
      "Content-Type":"application/json",
      "Authorization":token,
      "lang":lang,

    };

    return dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}