// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_suscrip.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSuscribeProviderHash() =>
    r'65ac6a48ff549b6437077911749dbed0d4733017';

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

/// See also [getSuscribeProvider].
@ProviderFor(getSuscribeProvider)
const getSuscribeProviderProvider = GetSuscribeProviderFamily();

/// See also [getSuscribeProvider].
class GetSuscribeProviderFamily
    extends Family<AsyncValue<List<SuscribeModel>>> {
  /// See also [getSuscribeProvider].
  const GetSuscribeProviderFamily();

  /// See also [getSuscribeProvider].
  GetSuscribeProviderProvider call({
    bool updateState = true,
  }) {
    return GetSuscribeProviderProvider(
      updateState: updateState,
    );
  }

  @override
  GetSuscribeProviderProvider getProviderOverride(
    covariant GetSuscribeProviderProvider provider,
  ) {
    return call(
      updateState: provider.updateState,
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
  String? get name => r'getSuscribeProviderProvider';
}

/// See also [getSuscribeProvider].
class GetSuscribeProviderProvider
    extends AutoDisposeFutureProvider<List<SuscribeModel>> {
  /// See also [getSuscribeProvider].
  GetSuscribeProviderProvider({
    bool updateState = true,
  }) : this._internal(
          (ref) => getSuscribeProvider(
            ref as GetSuscribeProviderRef,
            updateState: updateState,
          ),
          from: getSuscribeProviderProvider,
          name: r'getSuscribeProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSuscribeProviderHash,
          dependencies: GetSuscribeProviderFamily._dependencies,
          allTransitiveDependencies:
              GetSuscribeProviderFamily._allTransitiveDependencies,
          updateState: updateState,
        );

  GetSuscribeProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.updateState,
  }) : super.internal();

  final bool updateState;

  @override
  Override overrideWith(
    FutureOr<List<SuscribeModel>> Function(GetSuscribeProviderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSuscribeProviderProvider._internal(
        (ref) => create(ref as GetSuscribeProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        updateState: updateState,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SuscribeModel>> createElement() {
    return _GetSuscribeProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSuscribeProviderProvider &&
        other.updateState == updateState;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, updateState.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSuscribeProviderRef
    on AutoDisposeFutureProviderRef<List<SuscribeModel>> {
  /// The parameter `updateState` of this provider.
  bool get updateState;
}

class _GetSuscribeProviderProviderElement
    extends AutoDisposeFutureProviderElement<List<SuscribeModel>>
    with GetSuscribeProviderRef {
  _GetSuscribeProviderProviderElement(super.provider);

  @override
  bool get updateState => (origin as GetSuscribeProviderProvider).updateState;
}

String _$updateSuscribeHash() => r'721212cb8e5915d8d20e87a2acff9f88f608d0a2';

/// See also [UpdateSuscribe].
@ProviderFor(UpdateSuscribe)
final updateSuscribeProvider =
    AutoDisposeNotifierProvider<UpdateSuscribe, bool>.internal(
  UpdateSuscribe.new,
  name: r'updateSuscribeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateSuscribeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateSuscribe = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
