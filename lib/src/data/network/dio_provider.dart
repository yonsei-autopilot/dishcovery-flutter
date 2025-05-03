import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/network/auth_interceptor.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';

final dioProvider = Provider<DioService>((ref) {
  final baseUrl = dotenv.get("APP_BASE_URL");

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  dio.interceptors.add(AuthInterceptor(ref));

  return DioService(dio);
});

class DioService {
  final Dio _dio;

  DioService(this._dio);

  Future<T> request<T>({
    required ApiPath path,
    required HttpMethod method,
    Map<String, dynamic>? query,
    dynamic body,
    Options? options,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final response = await _dio.request(
        path.path,
        options: (options ?? Options(method: method.name)),
        queryParameters: query,
        data: body,
      );

      if (decoder != null) {
        return decoder(response.data);
      }

      return response.data as T;

    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    }
  }
}
