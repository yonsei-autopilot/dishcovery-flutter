abstract class FoodAversionRepository {
  Future<List<String>> getAversions();
  Future<void> saveAversions(List<String> aversions);
  Future<List<String>> fetchFromServer();
  Future<void> syncToServer(List<String> aversions);
}