import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/core/errors/expentions.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl =  'https://api.themoviedb.org/3';
    dio.options.headers = {
      'accept': 'application/json',
      'Authorization':"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMzVjMGQzNDg3NTMyNGI4ZWVlYTA2NGQxYmFlNWZmOSIsInN1YiI6IjY0YTE2OTNjZDUxOTFmMDEzOTNlODhhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NSrpPiCM2H-TEA0S2Vbd7DUt84bOWqAoxYuvcLIsvz8" ,
    };
  }

//!POST
  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      var res = dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

//!GET
  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var res =
          await dio.get(path, data: data, queryParameters: queryParameters);
          log("GET request to ${dio.options.baseUrl} with query parameters: $queryParameters");
      if (res.statusCode == 200) {
        log("Response data: ${res.data}");
      } else {
        log("Error: ${res.statusCode} - ${res.statusMessage}");
      }
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

//!DELETE
  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

//!PATCH
  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      var res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
