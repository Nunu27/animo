import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/api_response.dart';
import 'package:animo/models/user.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/type_defs.dart';
import 'package:animo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService(ref);
});

class ApiService {
  final Ref _ref;
  String? token;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.api,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) => true,
    ),
  );

  ApiService(this._ref) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) options.headers['Authorization'] = "Bearer $token";
          return handler.next(options);
        },
      ),
    );
  }

  FutureEither<String> getVersion() async {
    try {
      final request = dio.get("/");
      final response = await _handleApi(request);

      return right(response.version!);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<User> getUser() async {
    try {
      final request = dio.get('/user');
      final response = await _handleApi(request);

      return right(User.fromMap(response.data));
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid updatePushToken({String? oldToken, String? newToken}) async {
    try {
      final request = dio.post('/user/push_token', data: {
        'old_token': oldToken,
        'push_token': newToken,
      });
      await _handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final request = dio.post(
        '/auth/signin',
        data: {
          "email": email,
          "password": password,
        },
      );
      final response = await _handleApi(request);
      final pushToken = _ref.read(notificationProvider).token;

      token = response.data;

      if (pushToken != null) await updatePushToken(newToken: pushToken);
      return await getUser();
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<FutureEither<ApiResponse> Function(String)> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final request = dio.post(
        '/auth/signup',
        data: {
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      final response = await _handleApi(request);

      return right((otp) async {
        return await verify(otp: otp, session: response.data);
      });
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<ApiResponse> verify({
    required String session,
    required String otp,
  }) async {
    try {
      final request = dio.post(
        '/auth/verify',
        data: {
          "session": session,
          "otp": otp,
        },
      );

      return right(await _handleApi(request));
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<FutureEither<ApiResponse> Function(String)> forgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final request = dio.post('/auth/forgot-password', data: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });
      final response = await _handleApi(request);

      return right(
        (otp) async {
          return await verify(otp: otp, session: response.data);
        },
      );
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<FutureEither<ApiResponse> Function(String)>
      deleteAccount() async {
    try {
      final request = dio.delete('/user');
      final response = await _handleApi(request);

      return right(
        (otp) async {
          return await verify(otp: otp, session: response.data);
        },
      );
    } catch (e) {
      return left(getError(e));
    }
  }

  Future<ApiResponse> _handleApi<T>(
    Future<Response<dynamic>> request,
  ) async {
    final raw = await request;
    final ApiResponse response = ApiResponse.fromJson(raw.data);
    if (!response.success) {
      throw response.message ?? "Something is wrong";
    }

    return response;
  }
}
