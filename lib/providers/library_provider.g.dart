// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryHash() => r'54fe2009726ac6605e4f5c9785c01d88199932d0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Library
    extends BuildlessAutoDisposeNotifier<List<MediaBasic>> {
  late final MediaType type;

  List<MediaBasic> build(
    MediaType type,
  );
}

/// See also [Library].
@ProviderFor(Library)
const libraryProvider = LibraryFamily();

/// See also [Library].
class LibraryFamily extends Family<List<MediaBasic>> {
  /// See also [Library].
  const LibraryFamily();

  /// See also [Library].
  LibraryProvider call(
    MediaType type,
  ) {
    return LibraryProvider(
      type,
    );
  }

  @override
  LibraryProvider getProviderOverride(
    covariant LibraryProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'libraryProvider';
}

/// See also [Library].
class LibraryProvider
    extends AutoDisposeNotifierProviderImpl<Library, List<MediaBasic>> {
  /// See also [Library].
  LibraryProvider(
    MediaType type,
  ) : this._internal(
          () => Library()..type = type,
          from: libraryProvider,
          name: r'libraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryHash,
          dependencies: LibraryFamily._dependencies,
          allTransitiveDependencies: LibraryFamily._allTransitiveDependencies,
          type: type,
        );

  LibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final MediaType type;

  @override
  List<MediaBasic> runNotifierBuild(
    covariant Library notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(Library Function() create) {
    return ProviderOverride(
      origin: this,
      override: LibraryProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Library, List<MediaBasic>>
      createElement() {
    return _LibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LibraryRef on AutoDisposeNotifierProviderRef<List<MediaBasic>> {
  /// The parameter `type` of this provider.
  MediaType get type;
}

class _LibraryProviderElement
    extends AutoDisposeNotifierProviderElement<Library, List<MediaBasic>>
    with LibraryRef {
  _LibraryProviderElement(super.provider);

  @override
  MediaType get type => (origin as LibraryProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
