import 'package:animo/models/api_response.dart';
import 'package:dio/dio.dart';

abstract class ApiRepository {
  final Dio api;

  ApiRepository(this.api);

  Future<ApiResponse> handleApi(
    Future<Response<dynamic>> request,
  ) async {
    final raw = await request;
    final ApiResponse response = ApiResponse.fromMap(raw.data);
    if (!response.success) {
      throw response.message ?? 'Something is wrong';
    }

    return response;
  }
}
