import 'dart:convert';

class ResponseDTO {
  ResponseDTO({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseDTO.fromMap(Map<String, dynamic> map) {
    return ResponseDTO(
      code: map['code'],
      status: map['status'],
      message: map['message'],
      data: map['data'],
    );
  }

  factory ResponseDTO.fromJson(String source) =>
      ResponseDTO.fromMap(json.decode(source));

  final int code;
  final bool status;
  final String message;
  final dynamic data;

  ResponseDTO copyWith({
    int? code,
    bool? status,
    String? message,
    dynamic data,
  }) {
    return ResponseDTO(
      code: code ?? this.code,
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ResponseDTO(code: $code, status: $status,'
        ' message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseDTO &&
        other.code == code &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode {
    return code.hashCode ^ status.hashCode ^ message.hashCode ^ data.hashCode;
  }
}
