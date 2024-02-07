import 'package:animo/constants/box_constants.dart';
import 'package:animo/constants/constants.dart';
import 'package:animo/constants/url_constants.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@riverpod
Dio apiClient(ApiClientRef ref) {
  final Box box = Hive.box(BoxConstants.main);

  final dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.api,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
      validateStatus: (status) => true,
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = box.get(BoxConstants.tokenKey);
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ),
  );

  return dio;
}
