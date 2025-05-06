import 'package:smart_menu_flutter/src/domain/entities/food_item.dart';

abstract class PrefRepository {
  Future<List<FoodItem>> loadFoodItemFromTxt(String path);
}