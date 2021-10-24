class ServerResponse {
  bool? status;
  String? message;
  String? link;

  ServerResponse({
    required this.status,
    required this.message,
    this.link,
  });
}
