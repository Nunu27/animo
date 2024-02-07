import 'package:animo/models/abstract/api_repository.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/providers/api_client.dart';
import 'package:animo/type_defs.dart';
import 'package:animo/utils/utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_repository.g.dart';

@riverpod
LibraryRepository libraryRepository(LibraryRepositoryRef ref) {
  return LibraryRepository(ref.watch(apiClientProvider));
}

class LibraryRepository extends ApiRepository {
  LibraryRepository(super.api);

  FutureVoid import(List<String> slugs, DataSource source) async {
    try {
      final request = api
          .post('/user/import', data: {'slugs': slugs, 'source': source.name});
      await handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<MediaBasic>> getLibrary() async {
    try {
      final request = api.get('/user/library');
      final response = await handleApi(request);

      return right(
        (response.data as List).map((e) => MediaBasic.fromMap(e)).toList(),
      );
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<String>> addToLibrary(List<String> slugs) async {
    try {
      final request = api.put('/user/library', data: {'slugs': slugs});
      final response = await handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureEither<List<String>> removeFromLibrary(List<String> slugs) async {
    try {
      final request = api.delete('/user/library', data: {'slugs': slugs});
      final response = await handleApi(request);

      return right(response.data);
    } catch (e) {
      return left(getError(e));
    }
  }

  FutureVoid clearLibrary() async {
    try {
      final request = api.post('/user/library/clear');
      await handleApi(request);

      return right(null);
    } catch (e) {
      return left(getError(e));
    }
  }
}
