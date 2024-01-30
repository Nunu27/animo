import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/api_response.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/abstract/meta_provider.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/models/user.dart';
import 'package:animo/services/meta_sources/anilist/anilist.dart';
import 'package:animo/services/meta_sources/mal/mal.dart';
import 'package:animo/services/media_sources/anime/anime.dart';
import 'package:animo/services/media_sources/manga/manga.dart';
import 'package:animo/services/media_sources/novel/novel.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/type_defs.dart';
import 'package:animo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService(ref);
});

final getSyncDataProvider = FutureProvider.family((
  ref,
  BaseData baseMedia,
) async {
  return ref.watch(apiServiceProvider).getSyncData(baseMedia);
});

final getMediaProvider = FutureProvider.family((ref, BaseData baseMedia) async {
  final syncData = await ref.watch(getSyncDataProvider(baseMedia).future);

  return await ref.watch(apiServiceProvider).getMedia(syncData);
});

class ApiService {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.api,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => true,
    ),
  );

  String? token;

  ApiService(this._ref) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  FutureEither<String> getVersion() async {
    try {
      final request = _dio.get('/');
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
          'email': email,
          'password': password,
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
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
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
          'session': session,
          'otp': otp,
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

  // Library

  FutureVoid import(List<String> slugs, DataSource source) async {
    try {
      final request = _dio
          .post('/user/import', data: {'slugs': slugs, 'source': source.name});
      await _handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<MediaBasic>> getLibrary() async {
    try {
      final request = _dio.get('/user/library');
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

  FutureEither<List<String>> addToLibrary(List<String> slugs) async {
    try {
      final request = _dio.put('/user/library', data: {'slugs': slugs});
      final response = await _handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<String>> removeFromLibrary(List<String> slugs) async {
    try {
      final request = _dio.delete('/user/library', data: {'slugs': slugs});
      final response = await _handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid clearLibrary() async {
    try {
      final request = _dio.post('/user/library/clear');
      await _handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  // Media
  Future<SyncData> getSyncData(BaseData baseData) async {
    final request = _dio.post('/sync-data', data: {
      'slug': baseData.parentSlug ?? baseData.slug,
      'type': baseData.type.name,
    });
    final response = await _handleApi(request);

    return SyncData.fromMap(response.data);
  }

  Future<List<MediaBasic>> getMediaBasics(
    List<String> slugs,
    DataSource source,
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

  Future<Media> getMedia(SyncData syncData) async {
    Provider<MediaProvider> mediaProvider = _getMediaProvider(syncData.type);
    Provider<MetaProvider>? metaProvider = _getMetaProvider(syncData);

    final List<Future> futures = [_ref.read(mediaProvider).getMedia(syncData)];
    if (metaProvider != null) {
      futures.add(_ref.read(metaProvider).getMeta(syncData));
    }

    final results = await Future.wait(futures);

    switch (results) {
      case [
          final media as Media,
          final meta as MediaMeta,
        ]:
        return media.withMeta(meta);
      default:
        return results.first as Media;
    }
  }

  // Utils
  Provider<MediaProvider> _getMediaProvider(MediaType type) {
    return switch (type) {
      MediaType.anime => animeProvider,
      MediaType.manga => mangaProvider,
      MediaType.novel => novelProvider,
    } as Provider<MediaProvider>;
  }

  Provider<MetaProvider>? _getMetaProvider(SyncData syncData) {
    if (syncData.aniId != null) {
      return anilistProvider;
    } else if (syncData.malId != null) {
      return malProvider;
    } else {
      return null;
    }
  }

  Future<ApiResponse> _handleApi<T>(
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
