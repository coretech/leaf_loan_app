abstract class HttpHelper {
  Future<HttpResponse> get({
    Duration? cacheAge,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  });

  Future<HttpResponse> patch({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  });

  Future<HttpResponse> post({
    Duration? cacheAge,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  });

  Future<HttpResponse> put({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  });

  Future<HttpResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  });
}

class HttpResponse {
  HttpResponse({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final dynamic data;
}
