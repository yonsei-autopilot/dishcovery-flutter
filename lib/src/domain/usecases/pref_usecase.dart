import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/repositories/pref_repo.dart';
import 'package:smart_menu_flutter/src/domain/entities/food_item.dart';
import 'package:smart_menu_flutter/src/domain/repositories/pref_repository.dart';

final prefUseCaseProvider = Provider<PrefUseCase> ((ref) {
  final repo = ref.read(prefRepositoryProvider);
  return PrefUseCase(repo);
});

class PrefUseCase {
  final PrefRepository repo;
  PrefUseCase(this.repo);

  Future<List<FoodItem>> getList(String path) {
    return repo.loadFoodItemFromTxt(path);
  }
}