import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/usecases/food_aversion_usecase.dart';

final aversionsProvider = StateNotifierProvider<AversionsNotifier, AsyncValue<List<String>>>(
      (ref) => AversionsNotifier(ref.watch(foodAversionUseCaseProvider)),
);

class AversionsNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final FoodAversionUseCase _useCase;

  AversionsNotifier(this._useCase) : super(const AsyncValue.loading()) {
    loadAversions();
  }

  Future<void> loadAversions() async {
    state = const AsyncValue.loading();
    try {
      final data = await _useCase.getAversions();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> removeAversion(String item) async {
    final currentList = state.value ?? [];
    final newList = currentList.where((i) => i != item).toList();
    await _useCase.saveAversions(newList);
    loadAversions();
  }

  Future<void> addAversion(String foodName) async {
    final currentList = state.value ?? [];
    final newList = currentList.contains(foodName)
        ? currentList.where((item) => item != foodName).toList()
        : [...currentList, foodName];

    await _useCase.saveAversions(newList);
    loadAversions();
  }

  Future<void> test() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 500)); // 로딩 효과 시뮬레이션

    const testData = ["Almond butter", "Anchovies", "Oysters", "Passion fruit", "Aspartame"];
    state = const AsyncValue.data(testData);
  }
}
