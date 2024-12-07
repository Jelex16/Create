// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStatesProviderHash() => r'bb14e617c4b3967210bfb7b1494fefcafcdcda54';

/// See also [getStatesProvider].
@ProviderFor(getStatesProvider)
final getStatesProviderProvider =
    AutoDisposeFutureProvider<List<StateModel>>.internal(
  getStatesProvider,
  name: r'getStatesProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getStatesProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetStatesProviderRef = AutoDisposeFutureProviderRef<List<StateModel>>;
String _$getMunicipalitiesProviderHash() =>
    r'4e6ab574ad7695f912f82f94811ddf5a08f171f0';

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

/// See also [getMunicipalitiesProvider].
@ProviderFor(getMunicipalitiesProvider)
const getMunicipalitiesProviderProvider = GetMunicipalitiesProviderFamily();

/// See also [getMunicipalitiesProvider].
class GetMunicipalitiesProviderFamily
    extends Family<AsyncValue<List<MunicipalityModel>>> {
  /// See also [getMunicipalitiesProvider].
  const GetMunicipalitiesProviderFamily();

  /// See also [getMunicipalitiesProvider].
  GetMunicipalitiesProviderProvider call({
    String? id,
  }) {
    return GetMunicipalitiesProviderProvider(
      id: id,
    );
  }

  @override
  GetMunicipalitiesProviderProvider getProviderOverride(
    covariant GetMunicipalitiesProviderProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'getMunicipalitiesProviderProvider';
}

/// See also [getMunicipalitiesProvider].
class GetMunicipalitiesProviderProvider
    extends AutoDisposeFutureProvider<List<MunicipalityModel>> {
  /// See also [getMunicipalitiesProvider].
  GetMunicipalitiesProviderProvider({
    String? id,
  }) : this._internal(
          (ref) => getMunicipalitiesProvider(
            ref as GetMunicipalitiesProviderRef,
            id: id,
          ),
          from: getMunicipalitiesProviderProvider,
          name: r'getMunicipalitiesProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMunicipalitiesProviderHash,
          dependencies: GetMunicipalitiesProviderFamily._dependencies,
          allTransitiveDependencies:
              GetMunicipalitiesProviderFamily._allTransitiveDependencies,
          id: id,
        );

  GetMunicipalitiesProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    FutureOr<List<MunicipalityModel>> Function(
            GetMunicipalitiesProviderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMunicipalitiesProviderProvider._internal(
        (ref) => create(ref as GetMunicipalitiesProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MunicipalityModel>> createElement() {
    return _GetMunicipalitiesProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMunicipalitiesProviderProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMunicipalitiesProviderRef
    on AutoDisposeFutureProviderRef<List<MunicipalityModel>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetMunicipalitiesProviderProviderElement
    extends AutoDisposeFutureProviderElement<List<MunicipalityModel>>
    with GetMunicipalitiesProviderRef {
  _GetMunicipalitiesProviderProviderElement(super.provider);

  @override
  String? get id => (origin as GetMunicipalitiesProviderProvider).id;
}

String _$getColoniesProviderHash() =>
    r'0c6c8876ac2acd9e62a1c7e0a531df00471aa2d7';

/// See also [getColoniesProvider].
@ProviderFor(getColoniesProvider)
const getColoniesProviderProvider = GetColoniesProviderFamily();

/// See also [getColoniesProvider].
class GetColoniesProviderFamily
    extends Family<AsyncValue<List<ColoniesModel>>> {
  /// See also [getColoniesProvider].
  const GetColoniesProviderFamily();

  /// See also [getColoniesProvider].
  GetColoniesProviderProvider call({
    String? id,
  }) {
    return GetColoniesProviderProvider(
      id: id,
    );
  }

  @override
  GetColoniesProviderProvider getProviderOverride(
    covariant GetColoniesProviderProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'getColoniesProviderProvider';
}

/// See also [getColoniesProvider].
class GetColoniesProviderProvider
    extends AutoDisposeFutureProvider<List<ColoniesModel>> {
  /// See also [getColoniesProvider].
  GetColoniesProviderProvider({
    String? id,
  }) : this._internal(
          (ref) => getColoniesProvider(
            ref as GetColoniesProviderRef,
            id: id,
          ),
          from: getColoniesProviderProvider,
          name: r'getColoniesProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getColoniesProviderHash,
          dependencies: GetColoniesProviderFamily._dependencies,
          allTransitiveDependencies:
              GetColoniesProviderFamily._allTransitiveDependencies,
          id: id,
        );

  GetColoniesProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    FutureOr<List<ColoniesModel>> Function(GetColoniesProviderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetColoniesProviderProvider._internal(
        (ref) => create(ref as GetColoniesProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ColoniesModel>> createElement() {
    return _GetColoniesProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetColoniesProviderProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetColoniesProviderRef
    on AutoDisposeFutureProviderRef<List<ColoniesModel>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetColoniesProviderProviderElement
    extends AutoDisposeFutureProviderElement<List<ColoniesModel>>
    with GetColoniesProviderRef {
  _GetColoniesProviderProviderElement(super.provider);

  @override
  String? get id => (origin as GetColoniesProviderProvider).id;
}

String _$idMunicipalitiesHash() => r'f0387e4e18a544194632364da998062b747cdbf1';

/// See also [IdMunicipalities].
@ProviderFor(IdMunicipalities)
final idMunicipalitiesProvider =
    AutoDisposeNotifierProvider<IdMunicipalities, String>.internal(
  IdMunicipalities.new,
  name: r'idMunicipalitiesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$idMunicipalitiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IdMunicipalities = AutoDisposeNotifier<String>;
String _$idColoniesHash() => r'a787147705ded548ba91c2eb466b58a0531dcaa0';

/// See also [IdColonies].
@ProviderFor(IdColonies)
final idColoniesProvider =
    AutoDisposeNotifierProvider<IdColonies, String>.internal(
  IdColonies.new,
  name: r'idColoniesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$idColoniesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IdColonies = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
