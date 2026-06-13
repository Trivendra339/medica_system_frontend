import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_client.dart';

class ApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> get({required String url}) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }


  Future<dynamic> post({
    required String url,
    Object? body,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? e.message,
      );
    }
  }

  Future<dynamic> put({required String url, Object? body}) async {
    try {
      final response = await dio.put(url, data: jsonEncode(body));

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }
}
