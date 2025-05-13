import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_order_response.dart';
import 'package:smart_menu_flutter/src/domain/usecases/menu_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/menu_order_page.dart';

final menuOrderNotifierProvider = StateNotifierProvider.family<
    MenuOrderNotifier,
    AsyncValue<MenuOrderResponse>,
    MenuOrderPageParams>((ref, params) {
  final usecase = ref.read(menuUsecaseProvider);
  return MenuOrderNotifier(usecase, params);
});

class MenuOrderNotifier extends StateNotifier<AsyncValue<MenuOrderResponse>> {
  final MenuUsecase _usecase;
  final MenuOrderPageParams _params;
  final AudioPlayer _player = AudioPlayer();

  MenuOrderNotifier(this._usecase, this._params)
      : super(const AsyncValue.loading()) {
    _fetchOrder();
  }

  Future<void> _fetchOrder() async {
    try {
      (String, String) foreignLanguage = _usecase.getForeignLanguageOfMenu();

      final req = MenuOrderRequest(
        foreignLanguage: foreignLanguage.$1,
        foreignLanguageCode: foreignLanguage.$2,
        menus: _params.menuOrderDetailParams
            .map((p) => MenuOrderItem(
                  name: p.name,
                  count: p.count,
                  description: p.description,
                ))
            .toList(),
      );
      final resp = await _usecase.getMenuOrder(req);
      state = AsyncValue.data(resp);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> playOrderAudio() async {
    final b64 = state.value?.orderAudioBase64;
    if (b64 != null && b64.isNotEmpty) {
      final bytes = base64Decode(b64);
      await _player.play(BytesSource(bytes));
    }
  }

  Future<void> playInquiryAudio() async {
    final b64 = state.value?.inquiryAudioBase64;
    if (b64 != null && b64.isNotEmpty) {
      final bytes = base64Decode(b64);
      await _player.play(BytesSource(bytes));
    }
  }
}
