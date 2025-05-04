import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/local/auth_storage.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';

class AuthInterceptor extends Interceptor {
  final Ref<DioService> ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authStorage = ref.read(authStorageProvider);

    final accessToken = authStorage.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // TODO: 리프레시 토큰 처리 or 로그아웃 처리
    }
    handler.next(err); // 에러 전달
  }
}
