import 'package:smart_menu_flutter/src/data/repositories/menu_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_detail_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/menu_repository.dart';

final menuUsecaseProvider = Provider<MenuUsecase>((ref) {
  final repo = ref.read(menuRepositoryProvider);
  return MenuUsecase(repo);
});

class MenuUsecase {
  final MenuRepository repo;
  MenuUsecase(this.repo);

  Future<MenuTranslationResponse> analyzeMenuImage(String filePath) async {
    return await repo.getMenuTranslationAndBoundingBox(filePath);
  }

  Future<MenuDetailResponse> analyzeMenuDetail(String menuName) async {
    return await repo.getMenuDetail(menuName);
  }

  Future<MenuOrderResponse> getMenuOrder(MenuOrderRequest request) async {
    return await repo.getMenuOrder(request);
  }
}
