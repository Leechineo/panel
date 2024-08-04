import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:leechineo_panel/core/domain/adapters/database_adapter.dart';
import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';

class HttpAdapterImpl extends HttpAdapter {
  final Dio _dio = Dio();
  late final DatabaseAdapter _databaseAdapter;

  HttpAdapterImpl(DatabaseAdapter databaseAdapter)
      : super('http://192.168.18.53:4000') {
    _databaseAdapter = databaseAdapter;
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach JWT token to request headers if available.
          String? jwt = await _databaseAdapter.getValue('auth', 'token');
          if (jwt != null) {
            options.headers['Authorization'] = 'Bearer $jwt';
          }
          return handler.next(options);
        },
      ),
    );
  }
  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
      );
      return HttpResponse(
        response.statusCode ?? 500,
        response.data,
        response.headers.map,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HttpResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: params,
      );
      return HttpResponse(
        response.statusCode ?? 500,
        response.data,
        response.headers.map,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HttpResponse> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: params,
      );
      return HttpResponse(
        response.statusCode ?? 500,
        response.data,
        response.headers.map,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HttpResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: params,
      );
      return HttpResponse(
        response.statusCode ?? 500,
        response.data,
        response.headers.map,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HttpResponse> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return HttpResponse(
        response.statusCode ?? 500,
        response.data,
        response.headers.map,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  HttpResponse _handleError(dynamic error) {
    if (error is DioException) {
      return HttpResponse(
        error.response?.statusCode ?? 500,
        error.response?.data ?? {},
        error.response?.headers.map ?? {},
      );
    }
    return HttpResponse(
        500, {'error': 'app.internal_error', 'message': 'internal_error'}, {});
  }
}
