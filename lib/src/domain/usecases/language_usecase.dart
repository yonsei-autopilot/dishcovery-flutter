import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/repositories/language_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/language_repository.dart';

final languageUseCaseProvider = Provider<LanguageUseCase>((ref) {
  final repo = ref.read(languageRepositoryProvider);
  return LanguageUseCase(repo);
});

class LanguageUseCase {
  final LanguageRepository repo;
  LanguageUseCase(this.repo);

  Future<List<String>> getList() => repo.getLanguages();
  Future<String> fetchFromServer() => repo.fetchFromServer();
  Future<void> syncToServer(String language) => repo.syncToServer(language);
}
