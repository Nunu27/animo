import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/api_response.dart';
import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_provider.dart';
import 'package:animo/models/meta_provider.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/models/user.dart';
import 'package:animo/services/anilist.dart';
import 'package:animo/services/mal.dart';
import 'package:animo/services/media_source/anime.dart';
import 'package:animo/services/media_source/manga.dart';
import 'package:animo/services/media_source/novel.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/type_defs.dart';
import 'package:animo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService(ref);
});

final getMediaProvider =
    FutureProvider.family((ref, BaseMedia baseMedia) async {
  return await ref.watch(apiServiceProvider).getMedia(baseMedia);
});

class ApiService {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.api,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => true,
    ),
  );

  String? token;

  ApiService(this._ref) {
    _dio.interceptors.add(
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
      final request = _dio.get("/");
      final response = await _handleApi(request);

      return right(response.version!);
    } catch (e) {
      return left(getError(e));
    }
  }

  // Auth

  FutureEither<User> getUser() async {
    try {
      final request = _dio.get('/user');
      final response = await _handleApi(request);

      return right(User.fromMap(response.data));
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid updatePushToken({String? oldToken, String? newToken}) async {
    try {
      final request = _dio.post('/user/push_token', data: {
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
      final request = _dio.post(
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
      final request = _dio.post(
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
      final request = _dio.post(
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
      final request = _dio.post('/auth/forgot-password', data: {
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
      final request = _dio.delete('/user');
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

  // Favorites

  FutureVoid import(List<String> slugs, MediaSource source) async {
    try {
      final request = _dio
          .post('/user/import', data: {'slugs': slugs, 'source': source.name});
      await _handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<MediaBasic>> getFavorites() async {
    try {
      final request = _dio.get('/user/favorites');
      final response = await _handleApi(request);

      return right(
        (response.data as List<Map<String, dynamic>>)
            .map((e) => MediaBasic.fromMap(e))
            .toList(),
      );
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<String>> addFavorites(List<String> slugs) async {
    try {
      final request = _dio.put('/user/favorites', data: {'slugs': slugs});
      final response = await _handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<String>> removeFavorites(List<String> slugs) async {
    try {
      final request = _dio.delete('/user/favorites', data: {'slugs': slugs});
      final response = await _handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid clearFavorites() async {
    try {
      final request = _dio.post('/user/favorites/clear');
      await _handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  // Media
  Future<List<MediaBasic>> getMediaBasics(
    List<String> slugs,
    MediaSource source,
  ) async {
    final request = _dio.post('/media-basic', data: {
      'slugs': slugs,
      'source': source.name,
    });
    final response = await _handleApi(request);

    return (response.data as List<Map<String, dynamic>>)
        .map((e) => MediaBasic.fromMap(e))
        .toList();
  }

  Future<Media> getMedia(BaseMedia baseMedia) async {
    final request = _dio.post('/sync-data', data: {
      'slug': baseMedia.slug,
      'type': baseMedia.type.name,
    });
    final response = await _handleApi(request);

    final syncData = SyncData.fromMap(response.data);
    Provider<MetaProvider> provider;

    if (syncData.aniId != null) {
      provider = anilistProvider;
    } else if (syncData.malId != null) {
      provider = malProvider;
    } else {
      provider = _getMediaProvider(syncData.type);
    }

    return await _ref.read(provider).getMedia(syncData);
  }

  // Utils

  Provider<MediaProvider> _getMediaProvider(MediaType type) {
    switch (type) {
      case MediaType.anime:
        return animeProvider;
      case MediaType.manga:
        return mangaProvider;
      case MediaType.novel:
        return novelProvider;
    }
  }

  Future<ApiResponse> _handleApi<T>(
    Future<Response<dynamic>> request,
  ) async {
    final raw = await request;
    final ApiResponse response = ApiResponse.fromMap(raw.data);
    if (!response.success) {
      throw response.message ?? "Something is wrong";
    }

    return response;
  }
}
