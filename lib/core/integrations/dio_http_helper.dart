import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

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
  final FirebasePerformance _firebasePerformance =
  FirebasePerformance.instance;

  @override
  Future<HttpResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
    required String url,
  }) async {
    
    final metric = _firebasePerformance.newHttpMetric(
      url,
      HttpMethod.Delete,
    );
    await metric.start();
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      await _stopMetric(metric, response);
      log(
        '${response.statusCode} $url',
        name: 'DELETE',
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      await _stopMetric(metric, e.response);
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
    final metric = _firebasePerformance.newHttpMetric(
      url,
      HttpMethod.Get,
    );
    await metric.start();
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
      await _stopMetric(metric, response);
      log(
        '${response.statusCode} $url',
        name: 'GET',
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      await _stopMetric(metric, e.response);
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
    final metric = _firebasePerformance.newHttpMetric(
      url,
      HttpMethod.Patch,
    );
    await metric.start();
    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      await _stopMetric(metric, response);
      log(
        '${response.statusCode} $url',
        name: 'PATCH',
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      await _stopMetric(metric, e.response);
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
    final metric = _firebasePerformance.newHttpMetric(
      url,
      HttpMethod.Post,
    );
    await metric.start();
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
      await _stopMetric(metric, response);
      log(
        '${response.statusCode} $url',
        name: 'POST',
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      await _stopMetric(metric, e.response);
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
    final metric = _firebasePerformance.newHttpMetric(
      url,
      HttpMethod.Put,
    );
    await metric.start();
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: params,
      );
      await _stopMetric(metric, response);
      log(
        '${response.statusCode} $url',
        name: 'PUT',
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {
        onResponse(httpResponse);
      }
      return httpResponse;
    } on DioError catch (e, stackTrace) {
      await _stopMetric(metric, e.response);
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
    if (error.response?.statusCode != 401 &&
        error.response?.statusCode != 404) {
      IntegrationIOC.logger().logError(error, stackTrace);
    }
    return HttpResponse(
      data: error.response?.data,
      statusCode: error.response?.statusCode ?? 400,
    );
  }

  Future<void> _stopMetric(
    HttpMetric metric,
    Response? response,
  ) async {
    metric
      ..httpResponseCode = response?.statusCode
      ..responsePayloadSize = response?.data?.toString().length;
    await metric.stop();
    await IntegrationIOC.logger()
        .log('Response is ${response?.data?.toString() ?? 'null'}');
  }
}
