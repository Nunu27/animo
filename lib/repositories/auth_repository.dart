import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/abstract/api_repository.dart';
import 'package:animo/models/api_response.dart';
import 'package:animo/models/user.dart';
import 'package:animo/providers/api_client.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/type_defs.dart';
import 'package:animo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref: ref, api: ref.watch(apiClientProvider));
}

class AuthRepository extends ApiRepository {
  final Box _box = Hive.box(BoxConstants.main);
  final Ref _ref;

  String? get token => _box.get(BoxConstants.tokenKey);
  set token(String? token) => _box.put(BoxConstants.tokenKey, token);

  AuthRepository({required Ref ref, required Dio api})
      : _ref = ref,
        super(api);

  FutureEither<User> getUser() async {
    try {
      final request = api.get('/user');
      final response = await handleApi(request);

      return right(User.fromMap(response.data));
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid updatePushToken({String? oldToken, String? newToken}) async {
    try {
      final request = api.post('/user/push_token', data: {
        'oldToken': oldToken,
        'pushToken': newToken,
      });
      await handleApi(request);

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
      final request = api.post(
        '/auth/signin',
        data: {
          'email': email,
          'password': password,
        },
      );
      final response = await handleApi(request);
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
      final request = api.post(
        '/auth/signup',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      final response = await handleApi(request);

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
      final request = api.post(
        '/auth/verify',
        data: {
          'session': session,
          'otp': otp,
        },
      );

      return right(await handleApi(request));
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<OTPVerification> forgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final request = api.post('/auth/forgot-password', data: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });
      final response = await handleApi(request);

      return right(
        (otp) async {
          return await verify(otp: otp, session: response.data);
        },
      );
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<OTPVerification> deleteAccount() async {
    try {
      final request = api.delete('/user');
      final response = await handleApi(request);

      return right(
        (otp) async {
          return await verify(otp: otp, session: response.data);
        },
      );
    } catch (e) {
      return left(getError(e));
    }
  }
}
