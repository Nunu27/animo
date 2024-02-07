// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMediaHash() => r'903fe7046a9655742cddb7f74b82ada589e8e091';

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

/// See also [getMedia].
@ProviderFor(getMedia)
const getMediaProvider = GetMediaFamily();

/// See also [getMedia].
class GetMediaFamily extends Family<AsyncValue<Media>> {
  /// See also [getMedia].
  const GetMediaFamily();

  /// See also [getMedia].
  GetMediaProvider call({
    required MediaType type,
    required String slug,
  }) {
    return GetMediaProvider(
      type: type,
      slug: slug,
    );
  }

  @override
  GetMediaProvider getProviderOverride(
    covariant GetMediaProvider provider,
  ) {
    return call(
      type: provider.type,
      slug: provider.slug,
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
  String? get name => r'getMediaProvider';
}

/// See also [getMedia].
class GetMediaProvider extends AutoDisposeFutureProvider<Media> {
  /// See also [getMedia].
  GetMediaProvider({
    required MediaType type,
    required String slug,
  }) : this._internal(
          (ref) => getMedia(
            ref as GetMediaRef,
            type: type,
            slug: slug,
          ),
          from: getMediaProvider,
          name: r'getMediaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMediaHash,
          dependencies: GetMediaFamily._dependencies,
          allTransitiveDependencies: GetMediaFamily._allTransitiveDependencies,
          type: type,
          slug: slug,
        );

  GetMediaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.slug,
  }) : super.internal();

  final MediaType type;
  final String slug;

  @override
  Override overrideWith(
    FutureOr<Media> Function(GetMediaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMediaProvider._internal(
        (ref) => create(ref as GetMediaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Media> createElement() {
    return _GetMediaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMediaProvider &&
        other.type == type &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMediaRef on AutoDisposeFutureProviderRef<Media> {
  /// The parameter `type` of this provider.
  MediaType get type;

  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetMediaProviderElement extends AutoDisposeFutureProviderElement<Media>
    with GetMediaRef {
  _GetMediaProviderElement(super.provider);

  @override
  MediaType get type => (origin as GetMediaProvider).type;
  @override
  String get slug => (origin as GetMediaProvider).slug;
}

String _$getMediaBasicHash() => r'ba74e70fdbaec0d42d94bacf3244ca561cfff1da';

/// See also [getMediaBasic].
@ProviderFor(getMediaBasic)
const getMediaBasicProvider = GetMediaBasicFamily();

/// See also [getMediaBasic].
class GetMediaBasicFamily extends Family<AsyncValue<List<MediaBasic>>> {
  /// See also [getMediaBasic].
  const GetMediaBasicFamily();

  /// See also [getMediaBasic].
  GetMediaBasicProvider call({
    required List<BaseData> list,
    required DataSource source,
  }) {
    return GetMediaBasicProvider(
      list: list,
      source: source,
    );
  }

  @override
  GetMediaBasicProvider getProviderOverride(
    covariant GetMediaBasicProvider provider,
  ) {
    return call(
      list: provider.list,
      source: provider.source,
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
  String? get name => r'getMediaBasicProvider';
}

/// See also [getMediaBasic].
class GetMediaBasicProvider
    extends AutoDisposeFutureProvider<List<MediaBasic>> {
  /// See also [getMediaBasic].
  GetMediaBasicProvider({
    required List<BaseData> list,
    required DataSource source,
  }) : this._internal(
          (ref) => getMediaBasic(
            ref as GetMediaBasicRef,
            list: list,
            source: source,
          ),
          from: getMediaBasicProvider,
          name: r'getMediaBasicProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMediaBasicHash,
          dependencies: GetMediaBasicFamily._dependencies,
          allTransitiveDependencies:
              GetMediaBasicFamily._allTransitiveDependencies,
          list: list,
          source: source,
        );

  GetMediaBasicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
    required this.source,
  }) : super.internal();

  final List<BaseData> list;
  final DataSource source;

  @override
  Override overrideWith(
    FutureOr<List<MediaBasic>> Function(GetMediaBasicRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMediaBasicProvider._internal(
        (ref) => create(ref as GetMediaBasicRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
        source: source,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MediaBasic>> createElement() {
    return _GetMediaBasicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMediaBasicProvider &&
        other.list == list &&
        other.source == source;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);
    hash = _SystemHash.combine(hash, source.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMediaBasicRef on AutoDisposeFutureProviderRef<List<MediaBasic>> {
  /// The parameter `list` of this provider.
  List<BaseData> get list;

  /// The parameter `source` of this provider.
  DataSource get source;
}

class _GetMediaBasicProviderElement
    extends AutoDisposeFutureProviderElement<List<MediaBasic>>
    with GetMediaBasicRef {
  _GetMediaBasicProviderElement(super.provider);

  @override
  List<BaseData> get list => (origin as GetMediaBasicProvider).list;
  @override
  DataSource get source => (origin as GetMediaBasicProvider).source;
}

String _$getContentHash() => r'8129e0fb542f8925e461dfa74e6c5d115df7e6bb';

/// See also [getContent].
@ProviderFor(getContent)
const getContentProvider = GetContentFamily();

/// See also [getContent].
class GetContentFamily extends Family<AsyncValue<ContentData>> {
  /// See also [getContent].
  const GetContentFamily();

  /// See also [getContent].
  GetContentProvider call({
    required BaseData baseContent,
    bool withContentList = false,
    int? current,
  }) {
    return GetContentProvider(
      baseContent: baseContent,
      withContentList: withContentList,
      current: current,
    );
  }

  @override
  GetContentProvider getProviderOverride(
    covariant GetContentProvider provider,
  ) {
    return call(
      baseContent: provider.baseContent,
      withContentList: provider.withContentList,
      current: provider.current,
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
  String? get name => r'getContentProvider';
}

/// See also [getContent].
class GetContentProvider extends AutoDisposeFutureProvider<ContentData> {
  /// See also [getContent].
  GetContentProvider({
    required BaseData baseContent,
    bool withContentList = false,
    int? current,
  }) : this._internal(
          (ref) => getContent(
            ref as GetContentRef,
            baseContent: baseContent,
            withContentList: withContentList,
            current: current,
          ),
          from: getContentProvider,
          name: r'getContentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getContentHash,
          dependencies: GetContentFamily._dependencies,
          allTransitiveDependencies:
              GetContentFamily._allTransitiveDependencies,
          baseContent: baseContent,
          withContentList: withContentList,
          current: current,
        );

  GetContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseContent,
    required this.withContentList,
    required this.current,
  }) : super.internal();

  final BaseData baseContent;
  final bool withContentList;
  final int? current;

  @override
  Override overrideWith(
    FutureOr<ContentData> Function(GetContentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetContentProvider._internal(
        (ref) => create(ref as GetContentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseContent: baseContent,
        withContentList: withContentList,
        current: current,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ContentData> createElement() {
    return _GetContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetContentProvider &&
        other.baseContent == baseContent &&
        other.withContentList == withContentList &&
        other.current == current;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseContent.hashCode);
    hash = _SystemHash.combine(hash, withContentList.hashCode);
    hash = _SystemHash.combine(hash, current.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetContentRef on AutoDisposeFutureProviderRef<ContentData> {
  /// The parameter `baseContent` of this provider.
  BaseData get baseContent;

  /// The parameter `withContentList` of this provider.
  bool get withContentList;

  /// The parameter `current` of this provider.
  int? get current;
}

class _GetContentProviderElement
    extends AutoDisposeFutureProviderElement<ContentData> with GetContentRef {
  _GetContentProviderElement(super.provider);

  @override
  BaseData get baseContent => (origin as GetContentProvider).baseContent;
  @override
  bool get withContentList => (origin as GetContentProvider).withContentList;
  @override
  int? get current => (origin as GetContentProvider).current;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
