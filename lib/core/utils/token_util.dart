class TokenUtil {
  static MapEntry<String, String> generateBearer(String? token) {
    return MapEntry(
      'Authorization',
      'Bearer $token',
    );
  }
}
