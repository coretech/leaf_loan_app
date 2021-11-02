import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loan_app/features/authentication/authentication.dart';
import 'package:loan_app/features/authentication/presentation/bloc/auth/auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.authenticationRepository,
  ) : super(AuthStateInitial());
  final AuthenticationRepository authenticationRepository;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(Authenticating());
    var authResult = await authenticationRepository.login(
      username: username,
      password: password,
    );
    authResult.fold(
      (l) => emit(AuthenticationFailed()),
      (r) => emit(Authenticated()),
    );
  }
}
