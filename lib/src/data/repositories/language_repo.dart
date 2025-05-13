import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/user/get_user_language_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/user/update_user_language_request.dart';
import 'package:smart_menu_flutter/src/domain/repositories/language_repository.dart';

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final dioService = ref.read(dioProvider);
  final pref = ref.read(sharedPreferencesProvider);
  return LanguageRepositoryImpl(dioService, pref);
});

class LanguageRepositoryImpl implements LanguageRepository {
  final DioService dioService;
  final SharedPreferences pref;
  LanguageRepositoryImpl(this.dioService, this.pref);

  @override
  Future<List<String>> getLanguages() async {
    final jsonString = await rootBundle.loadString('assets/data/language.json');
    final List<dynamic> jsonlist = jsonDecode(jsonString);
    return jsonlist.cast<String>();
  }

  @override
  Future<String> fetchFromServer() async {
    final response = await dioService.request<
            ApiResponse<GetUserLanguageResponse>>(
        path: ApiPath.language,
        method: HttpMethod.GET,
        decoder: (json) => ApiResponse.fromJson(
            json,
            (j) =>
                GetUserLanguageResponse.fromJson(j as Map<String, dynamic>)));

    final language = response.data;

    if (language == null) {
      throw Exception('Language is null');
    }
    return language.language;
  }

  @override
  Future<void> syncToServer(String language) async {
    final response = await dioService.request<ApiResponse<void>>(
        path: ApiPath.language,
        method: HttpMethod.PUT,
        body: UpdateUserLanguageRequest(language: language),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        decoder: (json) => ApiResponse.fromJson(json, (_) {}));

    if (!response.isSuccess) {
      throw Exception('Language is not saved');
    }

    pref.setString('language', language);
  }
}
