abstract class LocalizationRepository {
  Future<void> setLanguage(String language);
  Future<String?> getLanguage();
}
