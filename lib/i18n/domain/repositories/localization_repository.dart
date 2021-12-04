abstract class L10nRepository {
  Future<void> setLanguage(String language);
  Future<String?> getLanguage();
}
