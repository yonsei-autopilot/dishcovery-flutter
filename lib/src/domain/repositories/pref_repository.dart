import 'package:smart_menu_flutter/src/domain/entities/pref_food_item.dart';

abstract class PrefRepository {
  Future<List<PrefFoodItem>> loadFoodItemFromTxt();
}