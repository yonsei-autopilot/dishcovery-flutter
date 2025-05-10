import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/repositories/food_aversion_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/food_aversion_repository.dart';

final foodAversionUseCaseProvider = Provider<FoodAversionUseCase>((ref) {
  final repo = ref.read(foodAversionRepositoryProvider);
  return FoodAversionUseCase(repo);
});

class FoodAversionUseCase {
  final FoodAversionRepository _repo;

  FoodAversionUseCase(this._repo);

  Future<List<String>> getAversions() => _repo.getAversions();
  Future<void> updateAversions(List<String> aversions) => _repo.updateAversions(aversions);
  Future<List<String>> fetchFromServer() => _repo.fetchFromServer();
  Future<void> syncToServer(List<String> aversions) => _repo.syncToServer(aversions);
}
