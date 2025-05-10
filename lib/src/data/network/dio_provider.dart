import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/network/auth_interceptor.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';

final dioProvider = Provider<DioService>((ref) {
  final baseUrl = dotenv.get("APP_BASE_URL");
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
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
    final effectiveOptions =
        options?.copyWith(method: method.name) ?? Options(method: method.name);

    try {
      final response = await _dio.request(
        path.path,
        options: effectiveOptions,
        queryParameters: query,
        data: body,
      );
      return _decodeResponse<T>(response.data, decoder);
    } on DioException catch (e) {
      if (_isTokenExpired(e)) {
        final retryResponse = await _retryRequest(e);
        return _decodeResponse<T>(retryResponse.data, decoder);
      }
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    }
  }

  bool _isTokenExpired(DioException e) {
    return e.response?.data?['error']['code'] == '5004';
  }

  Future<Response> _retryRequest(DioException e) async {
    final original = e.requestOptions;
    final retryData = _cloneRequestData(original.data);

    return await _dio.request(
      original.path,
      data: retryData,
      queryParameters: original.queryParameters,
      options: Options(
        method: original.method,
        headers: original.headers,
        contentType: original.contentType,
        responseType: original.responseType,
        sendTimeout: original.sendTimeout,
        receiveTimeout: original.receiveTimeout,
      ),
    );
  }

  dynamic _cloneRequestData(dynamic data) {
    if (data is! FormData) return data;

    final newFormData = FormData();
    newFormData.fields.addAll(data.fields);
    for (final entry in data.files) {
      newFormData.files.add(MapEntry(entry.key, entry.value.clone()));
    }
    return newFormData;
  }

  T _decodeResponse<T>(dynamic data, T Function(dynamic)? decoder) {
    return decoder != null ? decoder(data) : data as T;
  }
}
