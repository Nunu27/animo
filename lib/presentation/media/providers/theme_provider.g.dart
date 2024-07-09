// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colorscheme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$colorSchemeHash() => r'7a06c7d379163e6f427b86ee63d9359cb7729439';

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

/// See also [colorScheme].
@ProviderFor(colorScheme)
const colorSchemeProvider = ColorSchemeFamily();

/// See also [colorScheme].
class ColorSchemeFamily extends Family<AsyncValue<ColorScheme>> {
  /// See also [colorScheme].
  const ColorSchemeFamily();

  /// See also [colorScheme].
  ColorSchemeProvider call(
    String url,
  ) {
    return ColorSchemeProvider(
      url,
    );
  }

  @override
  ColorSchemeProvider getProviderOverride(
    covariant ColorSchemeProvider provider,
  ) {
    return call(
      provider.url,
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
  String? get name => r'colorSchemeProvider';
}

/// See also [colorScheme].
class ColorSchemeProvider extends AutoDisposeFutureProvider<ColorScheme> {
  /// See also [colorScheme].
  ColorSchemeProvider(
    String url,
  ) : this._internal(
          (ref) => colorScheme(
            ref as ColorSchemeRef,
            url,
          ),
          from: colorSchemeProvider,
          name: r'colorSchemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$colorSchemeHash,
          dependencies: ColorSchemeFamily._dependencies,
          allTransitiveDependencies:
              ColorSchemeFamily._allTransitiveDependencies,
          url: url,
        );

  ColorSchemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  Override overrideWith(
    FutureOr<ColorScheme> Function(ColorSchemeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ColorSchemeProvider._internal(
        (ref) => create(ref as ColorSchemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ColorScheme> createElement() {
    return _ColorSchemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ColorSchemeProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ColorSchemeRef on AutoDisposeFutureProviderRef<ColorScheme> {
  /// The parameter `url` of this provider.
  String get url;
}

class _ColorSchemeProviderElement
    extends AutoDisposeFutureProviderElement<ColorScheme> with ColorSchemeRef {
  _ColorSchemeProviderElement(super.provider);

  @override
  String get url => (origin as ColorSchemeProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
