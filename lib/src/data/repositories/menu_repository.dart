import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/menu_repository.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final dio = ref.read(dioProvider);
  return MenuRepositoryImpl(dio);
});

class MenuRepositoryImpl implements MenuRepository {
  final DioService dio;

  MenuRepositoryImpl(this.dio);

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
}
