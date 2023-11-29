abstract class ApiDao{
  Future<dynamic> getApi({required String url, Map<String, String>? headerParam});
}