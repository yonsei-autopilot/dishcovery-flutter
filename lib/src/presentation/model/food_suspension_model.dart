import 'package:azlistview/azlistview.dart';
import 'package:smart_menu_flutter/src/domain/entities/pref_food_item.dart';

class PrefFoodSuspensionModel extends ISuspensionBean {
  final String name;
  final String tagIndex;

  PrefFoodSuspensionModel({required this.name, required this.tagIndex});

  factory PrefFoodSuspensionModel.fromEntity(PrefFoodItem item) {
    return PrefFoodSuspensionModel(name: item.name, tagIndex: item.tagIndex);
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}