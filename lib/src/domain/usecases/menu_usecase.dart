import 'package:smart_menu_flutter/src/data/repositories/menu_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/foreign_language_of_menu_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_response.dart';
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

  Future<MenuExplanationResponse> analyzeMenuDetail(String menuName) async {
    var request = MenuExplanationRequest(name: menuName);
    return await repo.getMenuExplanation(request);
  }

  Future<MenuOrderResponse> getMenuOrder(MenuOrderRequest request) async {
    return await repo.getMenuOrder(request);
  }

  Future<void> getLanguageCodeForGoogleCodeFromServer(String snippetOfForeignLanguage) async {
    var request = ForeignLanguageOfMenuRequest(snippetOfForeignLanguage: snippetOfForeignLanguage);
    final response = await repo.getLanguageCodeForGoogleTtsFromServer(request);
    repo.saveLanguageCodeForGoogleTts(response.languageName, response.languageCode);
  }

  (String, String) getForeignLanguageOfMenu() {
    return repo.getForeignLanguageOfMenu();
  }
}
