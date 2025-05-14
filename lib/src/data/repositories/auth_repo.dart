import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/auth_storage.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/google_login_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/login_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/simple_login_request.dart';
import 'package:smart_menu_flutter/src/domain/errors/global_exception.dart';
import 'package:smart_menu_flutter/src/domain/errors/exception_type.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioService = ref.read(dioProvider);
  final tokenStorage = ref.read(authStorageProvider);
  final prefs = ref.read(sharedPreferencesProvider);
  return AuthRepositoryImpl(dioService, tokenStorage, prefs);
});

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DioService dioService;
  final AuthStorage tokenStorage;
  final SharedPreferences pref;

  AuthRepositoryImpl(this.dioService, this.tokenStorage, this.pref);

  @override
  Future<String> googleAuthenticate() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("Failed authentication from google");
    }

    final String? userId = googleUser.displayName;
    final String? email = googleUser.email;
    final String? image = googleUser.photoUrl;
    final user = User(
      id: userId,
      email: email,
      imageUrl: image
    );
    pref.setString('user', jsonEncode(user.toJson()));

    final GoogleSignInAuthentication authentication = await googleUser.authentication;
    String? accessToken = authentication.accessToken;
    if (accessToken == null) {
      throw Exception("Failed authentication from google; access token is null");
    }
    return accessToken;
  }

  @override
  Future<LoginResponse> googleLogin(String accessToken) async {
    try {
    final apiResponse = await dioService.request<ApiResponse<LoginResponse>>(
      path: ApiPath.googleLogin,
      method: HttpMethod.POST,
      body: GoogleLoginRequest(accessToken: accessToken).toJson(),
      decoder: (json) => ApiResponse.fromJson(json, (j) => LoginResponse.fromJson(j as Map<String, dynamic>)),
    );

      if (!apiResponse.isSuccess) {
        final error = apiResponse.error;
        if (error == null) {
          throw GlobalException(ExceptionType.unknown, 'Unknown API error');
        }
      }

      return apiResponse.data!;

    } catch (e) {
      if (e is GlobalException) rethrow;
      throw GlobalException(ExceptionType.networkError, 'Failed to connect to server');
    }
  }

  @override
  Future<LoginResponse> simpleLogin(SimpleLoginRequest request) async {
    try {
      final apiResponse = await dioService.request<ApiResponse<LoginResponse>>(
        path: ApiPath.simpleLogin,
        method: HttpMethod.POST,
        body: request.toJson(),
        decoder: (json) => ApiResponse.fromJson(json, (j) => LoginResponse.fromJson(j as Map<String, dynamic>)),
      );

      if (!apiResponse.isSuccess) {
        final error = apiResponse.error;
        if (error == null) {
          throw GlobalException(ExceptionType.unknown, 'Unknown API error');
        }
      }

      return apiResponse.data!; 

    } catch (e) {
      if (e is GlobalException) rethrow;
      throw GlobalException(ExceptionType.networkError, 'Failed to connect to server');
    }
  }

  @override
  void saveTokens(String accessToken, String refreshToken) {
    tokenStorage.setAccessToken(accessToken);
    tokenStorage.setRefreshToken(refreshToken);
  }
}
