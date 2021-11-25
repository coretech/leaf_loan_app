import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class DioHttpHelper implements HttpHelper {
  DioHttpHelper() {
    const _apiBaseUrl = String.fromEnvironment('API_URL');
    _dio = Dio();
    _dio.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: _apiBaseUrl),
      ).interceptor,
    );
  }
  late Dio _dio;

  @override
  Future<HttpResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      return _buildResponse(response);
    } on DioError catch (e) {
      return _buildResponseWithError(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> get({
    Duration? cacheAge,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  }) async {
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(
          cacheAge ?? Duration.zero,
          options: Options(
            headers: headers,
          ),
        ),
        queryParameters: params,
      );
      return _buildResponse(response);
    } on DioError catch (e) {
      return _buildResponseWithError(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> patch({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      return _buildResponse(response);
    } on DioError catch (e) {
      return _buildResponseWithError(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> post({
    Duration? cacheAge,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: buildCacheOptions(
          cacheAge ?? Duration.zero,
          options: Options(
            headers: headers,
          ),
        ),
        queryParameters: params,
      );
      return _buildResponse(response);
    } on DioError catch (e) {
      return _buildResponseWithError(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> put({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required String url,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      return _buildResponse(response);
    } on DioError catch (e) {
      return _buildResponseWithError(e);
    } catch (e) {
      rethrow;
    }
  }

  HttpResponse _buildResponse(Response response) {
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 400,
    );
  }

  HttpResponse _buildResponseWithError(DioError error) {
    return HttpResponse(
      data: error.response?.data,
      statusCode: error.response?.statusCode ?? 400,
    );
  }
}
