import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explanation_response.dart';
import 'package:smart_menu_flutter/src/domain/usecases/menu_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_detail/menu_detail_page.dart';

final menuDetailNotifierProvider = StateNotifierProvider.family<
    MenuDetailNotifier,
    AsyncValue<MenuExplanationResponse>,
    MenuDetailPageParams>((ref, params) {
  final usecase = ref.read(menuUsecaseProvider);
  return MenuDetailNotifier(usecase, params);
});

class MenuDetailNotifier
    extends StateNotifier<AsyncValue<MenuExplanationResponse>> {
  final MenuUsecase _usecase;
  final MenuDetailPageParams _params;

  MenuDetailNotifier(this._usecase, this._params)
      : super(const AsyncValue.loading()) {
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    try {
      final resp = await _usecase.analyzeMenuDetail(_params.menuName);
      state = AsyncValue.data(resp);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
