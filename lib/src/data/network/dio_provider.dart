import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_menu_flutter/src/data/local/token_storage.dart';
import 'package:smart_menu_flutter/src/data/network/auth_interceptor.dart';

final authDioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.read(tokenStorageProvider);

  final baseUrl = dotenv.get("APP_BASE_URL");

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  // 공통 인터셉터 추가 가능
  dio.interceptors.add(AuthInterceptor(tokenStorage));

  return dio;
});

final plainDioProvider = Provider<Dio>((ref) {
  final baseUrl = dotenv.get("APP_BASE_URL");

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  return dio;
});
