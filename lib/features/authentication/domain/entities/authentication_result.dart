import 'dart:convert';

class AuthenticationResult {
  final bool status;
  final String message;
  final String type;
  final String token;
  AuthenticationResult({
    required this.status,
    required this.message,
    required this.type,
    required this.token,
  });

  AuthenticationResult copyWith({
    bool? status,
    String? message,
    String? type,
    String? token,
  }) {
    return AuthenticationResult(
      status: status ?? this.status,
      message: message ?? this.message,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'type': type,
      'token': token,
    };
  }

  factory AuthenticationResult.fromMap(Map<String, dynamic> map) {
    return AuthenticationResult(
      status: map['status'],
      message: map['message'],
      type: map['type'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationResult.fromJson(String source) =>
      AuthenticationResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthenticationResult(status: $status, message: $message, type: $type, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticationResult &&
        other.status == status &&
        other.message == message &&
        other.type == type &&
        other.token == token;
  }

  @override
  int get hashCode {
    return status.hashCode ^ message.hashCode ^ type.hashCode ^ token.hashCode;
  }
}
