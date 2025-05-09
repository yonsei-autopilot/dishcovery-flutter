import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/repositories/language_repository.dart';

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  return LanguageRepositoryImpl();
});

class LanguageRepositoryImpl implements LanguageRepository {
  @override
  Future<List<String>> getLanguages() async {
    final jsonString = await rootBundle.loadString('assets/data/language.json');
    final List<dynamic> jsonlist = jsonDecode(jsonString);
    return jsonlist.cast<String>();
  }
}