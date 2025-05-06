import 'package:azlistview/azlistview.dart';
import 'package:smart_menu_flutter/src/domain/entities/food_item.dart';

class FoodSuspensionModel extends ISuspensionBean {
  final String name;
  final String tagIndex;

  FoodSuspensionModel({required this.name, required this.tagIndex});

  factory FoodSuspensionModel.fromEntity(FoodItem item) {
    return FoodSuspensionModel(name: item.name, tagIndex: item.tagIndex);
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}