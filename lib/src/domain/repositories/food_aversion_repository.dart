abstract class FoodAversionRepository {
  Future<List<String>> getAversions();
  Future<void> updateAversions(List<String> aversions);
  Future<List<String>> fetchFromServer();
  Future<void> syncToServer(List<String> aversions);
}