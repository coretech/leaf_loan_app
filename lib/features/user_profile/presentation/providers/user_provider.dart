import 'package:flutter/foundation.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';
import 'package:loan_app/features/user_profile/ioc/ioc.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserIOC.userRepo();

  bool loading = false;
  User? _user;
  String? errorMessage;

  User? get user => _user;

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  bool isReady() {
    return user != null && !loading;
  }

  String get fullName =>
      isReady() ? '${user!.firstName} ${user!.lastName}' : '';

  String get firstName => isReady() ? user!.firstName : '';

  String get usernamePresentation => isReady() ? '(${user?.username})' : '';

  bool get isVerified => isReady() && user!.status.toLowerCase() == 'active';

  String get address => isReady() ? _buildAddress() : '';

  String _buildAddress() {
    return '${user!.city}, ${user!.country}';
  }

  String get phoneNumber => isReady() ? user!.phone : '';

  Future<void> getUser() async {
    errorMessage = null;
    setLoading(value: true);
    final userEither = await _userRepository.getUser();
    userEither.fold(
      (_) {
        errorMessage = "We didn't get your profile. Try again please.";
      },
      (user) => _user = user,
    );
    setLoading(value: false);
    notifyListeners();
  }
}
