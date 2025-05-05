import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explain_response.dart';

abstract class MenuRepository {
  Future<MenuExplainResponse> getMenuTranslationAndBoundingBox(String filePath);
}
