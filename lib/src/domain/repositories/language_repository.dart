abstract class LanguageRepository {
  Future<List<String>> getLanguages();
  Future<String> fetchFromServer();
  Future<void> syncToServer(String language);
}