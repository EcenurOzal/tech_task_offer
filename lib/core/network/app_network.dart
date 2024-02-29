import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../exception/exception.dart';

enum HttpMethod { get, post, put, delete }

class ApiHelper {
  final Dio _dio;
  BaseOptions baseOptions;

  ApiHelper(this.baseOptions) : _dio = Dio(baseOptions) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  Future<Either<NetworkException, Response>> request(
    HttpMethod method,
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      Response? response;
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.post:
          response = await _dio.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.put:
          response = await _dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.delete:
          response = await _dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }
      if (response.statusCode != 200) {
        return Left(
          NetworkException(
            'HTTP Error',
            response.statusCode.toString(),
          ),
        );
      } else {
        return Right(
          response,
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkException(
          '${e.error}',
          null,
        ),
      );
    }
  }
}
