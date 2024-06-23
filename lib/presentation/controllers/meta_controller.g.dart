// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFeedHash() => r'14b97d27d88c6ecb65aafb172b8bfeb290507577';

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
class GetFeedFamily extends Family<AsyncValue<Feed>> {
  /// See also [getFeed].
  const GetFeedFamily();

  /// See also [getFeed].
  GetFeedProvider call(
    MediaType type,
  ) {
    return GetFeedProvider(
      type,
    );
  }

  @override
  GetFeedProvider getProviderOverride(
    covariant GetFeedProvider provider,
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
  String? get name => r'getFeedProvider';
}

/// See also [getFeed].
class GetFeedProvider extends AutoDisposeFutureProvider<Feed> {
  /// See also [getFeed].
  GetFeedProvider(
    MediaType type,
  ) : this._internal(
          (ref) => getFeed(
            ref as GetFeedRef,
            type,
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
    FutureOr<Feed> Function(GetFeedRef provider) create,
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
  AutoDisposeFutureProviderElement<Feed> createElement() {
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

mixin GetFeedRef on AutoDisposeFutureProviderRef<Feed> {
  /// The parameter `type` of this provider.
  MediaType get type;
}

class _GetFeedProviderElement extends AutoDisposeFutureProviderElement<Feed>
    with GetFeedRef {
  _GetFeedProviderElement(super.provider);

  @override
  MediaType get type => (origin as GetFeedProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member