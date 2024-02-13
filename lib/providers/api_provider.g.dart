// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFeedHash() => r'488513333637fc26398a78cad3b454a1dff572d3';

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

/// See also [getFeed].
@ProviderFor(getFeed)
const getFeedProvider = GetFeedFamily();

/// See also [getFeed].
class GetFeedFamily extends Family<AsyncValue<List<Feed>>> {
  /// See also [getFeed].
  const GetFeedFamily();

  /// See also [getFeed].
  GetFeedProvider call({
    required MediaType type,
  }) {
    return GetFeedProvider(
      type: type,
    );
  }

  @override
  GetFeedProvider getProviderOverride(
    covariant GetFeedProvider provider,
  ) {
    return call(
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
  String? get name => r'getFeedProvider';
}

/// See also [getFeed].
class GetFeedProvider extends AutoDisposeFutureProvider<List<Feed>> {
  /// See also [getFeed].
  GetFeedProvider({
    required MediaType type,
  }) : this._internal(
          (ref) => getFeed(
            ref as GetFeedRef,
            type: type,
          ),
          from: getFeedProvider,
          name: r'getFeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFeedHash,
          dependencies: GetFeedFamily._dependencies,
          allTransitiveDependencies: GetFeedFamily._allTransitiveDependencies,
          type: type,
        );

  GetFeedProvider._internal(
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
  Override overrideWith(
    FutureOr<List<Feed>> Function(GetFeedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetFeedProvider._internal(
        (ref) => create(ref as GetFeedRef),
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
  AutoDisposeFutureProviderElement<List<Feed>> createElement() {
    return _GetFeedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFeedProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetFeedRef on AutoDisposeFutureProviderRef<List<Feed>> {
  /// The parameter `type` of this provider.
  MediaType get type;
}

class _GetFeedProviderElement
    extends AutoDisposeFutureProviderElement<List<Feed>> with GetFeedRef {
  _GetFeedProviderElement(super.provider);

  @override
  MediaType get type => (origin as GetFeedProvider).type;
}

String _$getMediaHash() => r'903fe7046a9655742cddb7f74b82ada589e8e091';

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

String _$getMediaBasicHash() => r'ac334a4a460664b57e498f9ad71d568e4c4c4e79';

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

String _$getSourceHash() => r'b3f42cb06bd909195d5f13cd895dbc0df7ef104d';

/// See also [getSource].
@ProviderFor(getSource)
const getSourceProvider = GetSourceFamily();

/// See also [getSource].
class GetSourceFamily extends Family<AsyncValue<VideoData>> {
  /// See also [getSource].
  const GetSourceFamily();

  /// See also [getSource].
  GetSourceProvider call({
    required VideoServer videoServer,
  }) {
    return GetSourceProvider(
      videoServer: videoServer,
    );
  }

  @override
  GetSourceProvider getProviderOverride(
    covariant GetSourceProvider provider,
  ) {
    return call(
      videoServer: provider.videoServer,
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
  String? get name => r'getSourceProvider';
}

/// See also [getSource].
class GetSourceProvider extends AutoDisposeFutureProvider<VideoData> {
  /// See also [getSource].
  GetSourceProvider({
    required VideoServer videoServer,
  }) : this._internal(
          (ref) => getSource(
            ref as GetSourceRef,
            videoServer: videoServer,
          ),
          from: getSourceProvider,
          name: r'getSourceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSourceHash,
          dependencies: GetSourceFamily._dependencies,
          allTransitiveDependencies: GetSourceFamily._allTransitiveDependencies,
          videoServer: videoServer,
        );

  GetSourceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoServer,
  }) : super.internal();

  final VideoServer videoServer;

  @override
  Override overrideWith(
    FutureOr<VideoData> Function(GetSourceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSourceProvider._internal(
        (ref) => create(ref as GetSourceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoServer: videoServer,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<VideoData> createElement() {
    return _GetSourceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSourceProvider && other.videoServer == videoServer;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoServer.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSourceRef on AutoDisposeFutureProviderRef<VideoData> {
  /// The parameter `videoServer` of this provider.
  VideoServer get videoServer;
}

class _GetSourceProviderElement
    extends AutoDisposeFutureProviderElement<VideoData> with GetSourceRef {
  _GetSourceProviderElement(super.provider);

  @override
  VideoServer get videoServer => (origin as GetSourceProvider).videoServer;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
