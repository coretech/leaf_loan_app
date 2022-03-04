import 'dart:convert';

class ResponseDto {
  ResponseDto({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseDto.fromMap(Map<String, dynamic> map) {
    return ResponseDto(
      code: map['code'],
      status: map['status'],
      message: map['message'],
      data: map['data'],
    );
  }

  factory ResponseDto.fromJson(String source) =>
      ResponseDto.fromMap(json.decode(source));

  final int? code;
  final bool? status;
  final String message;
  final dynamic data;

  ResponseDto copyWith({
    int? code,
    bool? status,
    String? message,
    dynamic data,
  }) {
    return ResponseDto(
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

    return other is ResponseDto &&
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
