import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import '../../domain/repositories/food_aversion_repository.dart';

final foodAversionRepositoryProvider = Provider<FoodAversionRepository>((ref) {
  final sharedPref = ref.watch(sharedPreferencesProvider);
  return FoodAversionRepositoryImpl(sharedPref);
});

class FoodAversionRepositoryImpl implements FoodAversionRepository {
  final SharedPreferences sharedPreferences;
  FoodAversionRepositoryImpl(this.sharedPreferences);

  @override
  Future<List<String>> getAversions() async {
    return sharedPreferences.getStringList('food_aversions') ?? [];
  }

  @override
  Future<void> saveAversions(List<String> aversions) async {
    await sharedPreferences.setStringList('food_aversions', aversions);
  }

  @override
  Future<List<String>> fetchFromServer() {
    // TODO: implement fetchFromServer
    throw UnimplementedError();
  }

  @override
  Future<void> syncToServer(List<String> aversions) {
    // TODO: implement syncToServer
    throw UnimplementedError();
  }
  
}