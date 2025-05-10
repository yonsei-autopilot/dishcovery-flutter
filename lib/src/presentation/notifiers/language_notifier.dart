import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/usecases/language_usecase.dart';

final languageProvider =
    StateNotifierProvider<LanguageNotifier, AsyncValue<String>>(
  (ref) => LanguageNotifier(ref.watch(languageUseCaseProvider)),
);

class LanguageNotifier extends StateNotifier<AsyncValue<String>> {
  final LanguageUseCase _useCase;

  LanguageNotifier(this._useCase) : super(const AsyncValue.loading()) {
    initializeLanguage();
  }

  void updateLanguage(String language) {
    state = AsyncValue.data(language);
  }

  Future<void> initializeLanguage() async {
    state = const AsyncValue.loading();
    try {
      final lanuage = await _useCase.fetchFromServer();
      state = AsyncValue.data(lanuage);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> saveLanguage() async {
    final language = state.value ?? "English";
    state = const AsyncValue.loading();
    try {
      await _useCase.syncToServer(language);
      state = AsyncValue.data(language);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
