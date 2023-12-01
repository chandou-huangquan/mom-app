import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offer_system/common/api.dart';
import 'package:offer_system/utils/shared_preferences.dart';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class DioUtilss {
  /// global dio object
  static Dio dio;

  /// default options
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
  // static const String TOKEN = "1373a739fd8599909738511f41831623";

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
  static Future<String> getToken() async {
    SpUtil sp = await SpUtil.getInstance();
    String token = sp.getString("token");
    return token;
  }

  /// 创建 dio 实例对象
  static Future<Dio> createInstance() async {
    String token = await getToken();
    httpHeaders["Authorization"] = token;
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
          connectTimeout: 15000,
          receiveTimeout: 15000,
          responseType: ResponseType.json,
          validateStatus: (status) {
            // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
            return true;
          },
          baseUrl: Api.baseUrl,
          headers: httpHeaders);

      dio = new Dio(options);
    }

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求之前");

      return options;
    }, onResponse: (Response response) {
      print("响应之前");

      return response;
    }, onError: (DioError e) {
      print("错误之前");

      return e;
    }));
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  ///Get请求
  static Future<T> getHttp<T>(
    String url, {
    parameters,
  }) async {
    ///定义请求参数
    // parameters = parameters ?? {};
    // //参数处理
    // parameters.forEach((key, value) {
    //   if (url.indexOf(key) != -1) {
    //     url = url.replaceAll(':$key', value.toString());
    //   }
    // });
    // parameters = {};
    print(parameters);
    try {
      Response response;
      Dio dio = await createInstance();
      // Dio dio = new Dio();
      response = await dio.get(url, queryParameters: parameters);
      var responseData = response.data;
      if (responseData['code'] == 2000) {
        print('响应数据：' + response.toString());
        return responseData['data'];
      } else {
        print('响应数据：' + response.toString());
        Fluttertoast.showToast(
            msg: responseData['msg'],
            //toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          //  toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  ///Post请求
  static Future<T> postHttp<T>(
    String url, {
    parameters,
  }) async {
    // ///定义请求参数
    // parameters = parameters ?? {};
    // //参数处理
    // parameters.forEach((key, value) {
    //   if (url.indexOf(key) != -1) {
    //     url = url.replaceAll(':$key', value.toString());
    //   }
    // });
    print(parameters);
    try {
      Response response;
      Dio dio = await createInstance();
      response = await dio.post(url, queryParameters: parameters);
      var responseData = response.data;
      if (responseData['code'] == 2000) {
        print('响应数据：' + response.toString());
        return responseData['data'];
      } else {
        Fluttertoast.showToast(
            msg: responseData['msg'],
            //  toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          //  toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  /// request Get、Post 请求
  //url 请求链接
  //parameters 请求参数
  //method 请求方式
  //onSuccess 成功回调
  //onError 失败回调
  static Future<T> requestHttp<T>(String url, {parameters, method}) async {
    method = method ?? 'GET';
    print(parameters);
    if (method == DioUtilss.GET) {
      return getHttp(
        url,
        parameters: parameters,
      );
    } else if (method == DioUtilss.POST) {
      return postHttp(
        url,
        parameters: parameters,
      );
    } else {
      throw "搞错了重来";
    }
  }
}

/// 自定义Header
Map<String, dynamic> httpHeaders = {
  'Accept': 'application/json,*/*',
  'Content-Type': 'application/json'
  // 'token': DioUtils.TOKEN
};
