import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explain_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explain_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/menu_repository.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final dio = ref.read(dioProvider);
  return MenuRepositoryImpl(dio);
});

class MenuRepositoryImpl implements MenuRepository {
  final DioService dio;

  MenuRepositoryImpl(this.dio);

  @override
  Future<MenuExplainResponse> getMenuTranslationAndBoundingBox(
      String filePath) async {
    final image = File(filePath);
    final requestBody = await MenuExplainRequest(image).toFormData();

    final response = await dio.request<ApiResponse<MenuExplainResponse>>(
        path: ApiPath.menuExplanation,
        method: HttpMethod.POST,
        body: requestBody,
        decoder: (json) => ApiResponse.fromJson(json,
            (j) => MenuExplainResponse.fromJson(j as Map<String, dynamic>)));

    final menuExplain = response.data;

    if (menuExplain == null) {
      throw Exception('MenuExplainResponse is null');
    }

    return menuExplain;
  }
}
