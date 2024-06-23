import 'package:animo/data/repositories/meta_repository_impl.dart';
import 'package:animo/domain/repositories/meta_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories.g.dart';

@riverpod
MetaRepository metaRepository(MetaRepositoryRef ref) {
  return MetaRepositoryImpl();
}
