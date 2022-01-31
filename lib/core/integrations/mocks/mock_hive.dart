import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/keys.dart';
import 'package:mockito/mockito.dart';

class MockHive extends Mock implements LocalStorage {
  @override
  Future<String?> getString(String key) async {
    if (key == Keys.token) {
      return '';
    }
    return null;
  }

  @override
  Future<bool?> getBool(String key) async {
    if (key == Keys.onboardingStatus) {
      return false;
    }
    return null;
  }
}
