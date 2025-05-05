import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';

abstract class MenuRepository {
  Future<MenuTranslationResponse> getMenuTranslationAndBoundingBox(
      String filePath);
}
