import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/local/auth_storage.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = ref.read(authStorageProvider).getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldAttemptRefresh(err)) {
      final success = await _attemptTokenRefresh();
      if (success) {
        return handler.next(err);
      }
    }
    handler.next(err);
  }

  bool _shouldAttemptRefresh(DioException err) {
    return err.response?.data['error']?['code'] == '5004' &&
        !err.requestOptions.path.contains("/auth/refresh");
  }

  Future<bool> _attemptTokenRefresh() async {
    final authStorage = ref.read(authStorageProvider);
    final refreshToken = authStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final baseUrl = dotenv.get("APP_BASE_URL");
      final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
      final response = await refreshDio.post(
        "/auth/refresh",
        data: {'refreshToken': refreshToken},
      );
      final newAccessToken = response.data['data']?['accessToken'];
      if (newAccessToken == null) return false;
      await authStorage.setAccessToken(newAccessToken);
      return true;
    } catch (_) {
      return false;
    }
  }
}
