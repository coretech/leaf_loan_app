import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';

import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class DioHttpHelper implements HttpHelper {
  DioHttpHelper({
    required this.onResponse,
  }) {
    const _apiBaseUrl = String.fromEnvironment('API_URL');
    _dio = Dio();
    _dio.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: _apiBaseUrl),
      ).interceptor,
    );
  }
  late Dio _dio;
  final ValueChanged<HttpResponse> onResponse;

  @override
  Future<HttpResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
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
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {
        onResponse(errResponse);
      }
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> get({
    Duration? cacheAge,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
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
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {
        onResponse(errResponse);
      }
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> patch({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
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
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {
        onResponse(errResponse);
      }
      return errResponse;
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
    bool processResponse = true,
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
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {
        onResponse(errResponse);
      }
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> put({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
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
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      final errResponse = _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {
        onResponse(errResponse);
      }
      return errResponse;
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

  HttpResponse _buildResponseWithError(DioError error, StackTrace stackTrace) {
    if (error.response?.statusCode != 401) {
      IntegrationIOC.logger().logError(error, stackTrace);
    }
    return HttpResponse(
      data: error.response?.data,
      statusCode: error.response?.statusCode ?? 400,
    );
  }
}
