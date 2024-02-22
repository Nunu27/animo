// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryManagerHash() => r'2a682bce62d2922ab8737a659b3499d8c4a4c354';

/// See also [libraryManager].
@ProviderFor(libraryManager)
final libraryManagerProvider = AutoDisposeProvider<LibraryManager>.internal(
  libraryManager,
  name: r'libraryManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryManagerRef = AutoDisposeProviderRef<LibraryManager>;
String _$isInLibraryHash() => r'059dd53f32d6bc3c085448b09263229396477f1c';

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

/// See also [isInLibrary].
@ProviderFor(isInLibrary)
const isInLibraryProvider = IsInLibraryFamily();

/// See also [isInLibrary].
class IsInLibraryFamily extends Family<bool> {
  /// See also [isInLibrary].
  const IsInLibraryFamily();

  /// See also [isInLibrary].
  IsInLibraryProvider call({
    required String slug,
    required MediaType type,
  }) {
    return IsInLibraryProvider(
      slug: slug,
      type: type,
    );
  }

  @override
  IsInLibraryProvider getProviderOverride(
    covariant IsInLibraryProvider provider,
  ) {
    return call(
      slug: provider.slug,
      type: provider.type,
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
  String? get name => r'isInLibraryProvider';
}

/// See also [isInLibrary].
class IsInLibraryProvider extends AutoDisposeProvider<bool> {
  /// See also [isInLibrary].
  IsInLibraryProvider({
    required String slug,
    required MediaType type,
  }) : this._internal(
          (ref) => isInLibrary(
            ref as IsInLibraryRef,
            slug: slug,
            type: type,
          ),
          from: isInLibraryProvider,
          name: r'isInLibraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isInLibraryHash,
          dependencies: IsInLibraryFamily._dependencies,
          allTransitiveDependencies:
              IsInLibraryFamily._allTransitiveDependencies,
          slug: slug,
          type: type,
        );

  IsInLibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
    required this.type,
  }) : super.internal();

  final String slug;
  final MediaType type;

  @override
  Override overrideWith(
    bool Function(IsInLibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsInLibraryProvider._internal(
        (ref) => create(ref as IsInLibraryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsInLibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsInLibraryProvider &&
        other.slug == slug &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsInLibraryRef on AutoDisposeProviderRef<bool> {
  /// The parameter `slug` of this provider.
  String get slug;

  /// The parameter `type` of this provider.
  MediaType get type;
}

class _IsInLibraryProviderElement extends AutoDisposeProviderElement<bool>
    with IsInLibraryRef {
  _IsInLibraryProviderElement(super.provider);

  @override
  String get slug => (origin as IsInLibraryProvider).slug;
  @override
  MediaType get type => (origin as IsInLibraryProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
