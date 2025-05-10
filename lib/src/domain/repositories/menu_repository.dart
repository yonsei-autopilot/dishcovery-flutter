import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import '../dtos/menu/menu_detail_response.dart';

abstract class MenuRepository {
  Future<MenuTranslationResponse> getMenuTranslationAndBoundingBox(
      String filePath);

  Future<MenuDetailResponse> getMenuDetail(String menuName);

  Future<MenuOrderResponse> getMenuOrder(MenuOrderRequest request);
}
