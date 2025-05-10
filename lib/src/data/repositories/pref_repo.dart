import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/entities/pref_food_item.dart';
import 'package:smart_menu_flutter/src/domain/repositories/pref_repository.dart';

final prefRepositoryProvider = Provider<PrefRepository>((ref) {
  return PrefImplRepository();
});

class PrefImplRepository implements PrefRepository {
  @override
  Future<List<PrefFoodItem>> loadFoodItemFromTxt() async {
    String content = await rootBundle.loadString('assets/data/allergens_and_polarizing_foods_sorted.txt');
    List<String> lines = content.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    final items = lines.map((name) {
      final tag = name.isNotEmpty && RegExp(r'^[A-Za-z]').hasMatch(name[0]) ?
          name[0].toUpperCase() : '#';
      return PrefFoodItem(name: name, tagIndex: tag);
    }).toList();
    return items;
  }
}