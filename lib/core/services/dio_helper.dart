// ignore_for_file: avoid_print

import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void initialize() {
    BaseOptions options = BaseOptions(
      headers: {},
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  static Future<Response> get(String url,
      {Map<String, dynamic>? query, String? token, FormData? formData}) async {
    Response response = await dio.get(url,
        queryParameters: query,
        data: formData,
        options: Options(headers: {'Authorization': token ?? ''}));
    print(response);
    return response;
  }

  static Future<Response> patch({
    required String url,
    FormData? formData,
    String? token,
  }) async {
    Response response = await dio.patch(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
    print(response);
    return response;
  }

  static Future<Response> put({
    required String url,
    FormData? formData,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    Response response = await dio.put(
      url,
      queryParameters: query,
      data: formData,
      options: Options(
        headers: {'Authorization': token ?? ''},
      ),
    );
    print(response);
    return response;
  }

  static Future<Response> post(String url,
      {Map<String, dynamic>? data, String? token}) async {
    Response response = await dio.post(url,
        data: data,
        options: Options(
          headers: {'Authorization': token ?? ''},
          contentType: 'multipart/form-data',
        ));
    print(response);
    return response;
  }

  static Future<Response> postForm(String url,
      {required FormData data, String? token}) async {
    Response response = await dio.post(url,
        data: data,
        options: Options(
          headers: {'Authorization': token ?? ''},
          contentType: 'multipart/form-data',
        ));

    print(response);

    return response;
  }

  static Future<Response> delete(String url,
      {Map<String, dynamic>? query}) async {
    Response response = await dio.delete(url, queryParameters: query);
    return response;
  }
}
