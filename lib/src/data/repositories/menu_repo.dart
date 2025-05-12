import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/local/foreign_language_of_menu.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/language_code_for_google_tts_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/language_code_for_google_tts_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/menu_repository.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final dio = ref.read(dioProvider);
  final foreignLanguageOfMenuStorage = ref.read(foreignLanguageOfMenuStorageProvider);
  return MenuRepositoryImpl(dio, foreignLanguageOfMenuStorage);
});

class MenuRepositoryImpl implements MenuRepository {
  final DioService dio;
  final ForeignLanguageOfMenuStorage foreignLanguageOfMenuStorage;

  MenuRepositoryImpl(this.dio, this.foreignLanguageOfMenuStorage);

  @override
  Future<MenuTranslationResponse> getMenuTranslationAndBoundingBox(
      String filePath) async {
    final image = File(filePath);
    final requestBody = await MenuTranslationRequest(image).toFormData();

    final response = await dio.request<ApiResponse<MenuTranslationResponse>>(
        path: ApiPath.menuTranslation,
        method: HttpMethod.POST,
        body: requestBody,
        decoder: (json) => ApiResponse.fromJson(
            json,
            (j) =>
                MenuTranslationResponse.fromJson(j as Map<String, dynamic>)));

    final menuTranslation = response.data;

    if (menuTranslation == null) {
      throw Exception('MenuTranslationResponse is null');
    }

    return menuTranslation;
  }

  @override
  Future<MenuExplanationResponse> getMenuExplanation(
      MenuExplanationRequest request) async {
    final response = await dio.request<ApiResponse<MenuExplanationResponse>>(
        path: ApiPath.menuExplanation,
        method: HttpMethod.POST,
        body: request,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        decoder: (json) => ApiResponse.fromJson(
            json,
            (j) =>
                MenuExplanationResponse.fromJson(j as Map<String, dynamic>)));
    final menuExplanation = response.data;

    if (menuExplanation == null) {
      throw Exception('Menu explanation is null');
    }

    return menuExplanation;
  }

  @override
  Future<MenuOrderResponse> getMenuOrder(MenuOrderRequest request) async {
    final response = await dio.request<ApiResponse<MenuOrderResponse>>(
        path: ApiPath.menuOrder,
        method: HttpMethod.POST,
        body: request,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        decoder: (json) => ApiResponse.fromJson(json,
            (j) => MenuOrderResponse.fromJson(j as Map<String, dynamic>)));

    final menuOrder = response.data;

    if (menuOrder == null) {
      throw Exception('Menu order is null');
    }

    return menuOrder;
  }

  @override
  Future<ForeignLanguageOfMenuResponse> getLanguageCodeForGoogleTtsFromServer(ForeignLanguageOfMenuRequest request) async {
    final response = await dio.request<ApiResponse<ForeignLanguageOfMenuResponse>>(
        path: ApiPath.foreignLanguageOfMenu,
        method: HttpMethod.POST,
        body: request,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        decoder: (json) => ApiResponse.fromJson(json,
            (j) => ForeignLanguageOfMenuResponse.fromJson(j as Map<String, dynamic>)));

    final languageCode = response.data;

    if (languageCode == null) {
      throw Exception('Language Code is null');
    }

    return languageCode;
  }
  
  @override
  (String, String) getForeignLanguageOfMenu() {
    String? languageName = foreignLanguageOfMenuStorage.getLanguageName();
    String? languageCode = foreignLanguageOfMenuStorage.getLanguageCodeForGoogleCode();

    return (languageName ?? "English", languageCode ?? "en-US");
  }
  
  @override
  void saveLanguageCodeForGoogleTts(String languageName, String languageCode) {
    foreignLanguageOfMenuStorage.saveLanguageName(languageName);
    foreignLanguageOfMenuStorage.savegetLanguageCodeForGoogleCode(languageCode);
  }
}
