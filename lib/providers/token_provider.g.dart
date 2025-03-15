// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenNotifierHash() => r'1d64233ada94c33867b810937d371f8557e51b7e';

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

abstract class _$TokenNotifier extends BuildlessAutoDisposeNotifier<String> {
  late final String token;

  String build(String token);
}

/// See also [TokenNotifier].
@ProviderFor(TokenNotifier)
const tokenNotifierProvider = TokenNotifierFamily();

/// See also [TokenNotifier].
class TokenNotifierFamily extends Family<String> {
  /// See also [TokenNotifier].
  const TokenNotifierFamily();

  /// See also [TokenNotifier].
  TokenNotifierProvider call(String token) {
    return TokenNotifierProvider(token);
  }

  @override
  TokenNotifierProvider getProviderOverride(
    covariant TokenNotifierProvider provider,
  ) {
    return call(provider.token);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tokenNotifierProvider';
}

/// See also [TokenNotifier].
class TokenNotifierProvider
    extends AutoDisposeNotifierProviderImpl<TokenNotifier, String> {
  /// See also [TokenNotifier].
  TokenNotifierProvider(String token)
    : this._internal(
        () => TokenNotifier()..token = token,
        from: tokenNotifierProvider,
        name: r'tokenNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$tokenNotifierHash,
        dependencies: TokenNotifierFamily._dependencies,
        allTransitiveDependencies:
            TokenNotifierFamily._allTransitiveDependencies,
        token: token,
      );

  TokenNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  String runNotifierBuild(covariant TokenNotifier notifier) {
    return notifier.build(token);
  }

  @override
  Override overrideWith(TokenNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TokenNotifierProvider._internal(
        () => create()..token = token,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TokenNotifier, String> createElement() {
    return _TokenNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TokenNotifierProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TokenNotifierRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `token` of this provider.
  String get token;
}

class _TokenNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<TokenNotifier, String>
    with TokenNotifierRef {
  _TokenNotifierProviderElement(super.provider);

  @override
  String get token => (origin as TokenNotifierProvider).token;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
