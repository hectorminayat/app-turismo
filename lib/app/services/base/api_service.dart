import 'dart:io';
import 'package:dio/dio.dart';
import 'package:discoverrd/app/config/app_config.dart';
import 'package:get/get.dart';
import '../auth/token_service.dart';

class ApiService extends GetxService {
  final TokenService _tokenService = Get.find<TokenService>();
  Dio? _dio;

  Dio dio() {
    final token = _tokenService.getToken();
    return _dio ??
        Dio(BaseOptions(
            baseUrl: AppConfig.API_URL,
            headers: token != null
                ? {HttpHeaders.authorizationHeader: "Bearer $token"}
                : {}));
  }

  Future<T> getAll<T>(String url) async {
    try {
      final result = await dio().get(url);
      return result.data;
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<T> get<T>(String url, Map<String, dynamic>? queryParameters) async {
    try {
      final result = await dio().get(url, queryParameters: queryParameters);
      return result.data;
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<T> getById<T>(String url, id) async {
    try {
      final result = await dio().get("$url/$id");
      return result.data;
    } catch (err) {
      throw (err);
    }
  }

  Future<T> post<T>(String url, dynamic data) async {
    try {
      final result = await dio().post(url, data: data);
      return result.data;
    } catch (err) {
      if (err is DioError) {
        print((err).response.toString());
        throw ((err).response.toString());
      } else {
        throw ("Ha ocurrido un error");
      }
    }
  }

  Future<T> put<T>(String url, dynamic data) async {
    try {
      final result = await dio().put(url, data: data);
      return result.data;
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<T> delete<T>(String url, id) async {
    try {
      final result = await dio().delete("$url/$id");
      return result.data;
    } catch (err) {
      print(err);
      throw (err);
    }
  }
}
