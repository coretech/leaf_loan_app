abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationFailed extends AuthState {}
