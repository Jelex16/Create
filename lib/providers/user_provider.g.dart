// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserProviderHash() => r'c374f42a512d4a57746ef4fbaf620012d1b61391';

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

/// See also [getUserProvider].
@ProviderFor(getUserProvider)
const getUserProviderProvider = GetUserProviderFamily();

/// See also [getUserProvider].
class GetUserProviderFamily extends Family<AsyncValue<List<UserModel2>>> {
  /// See also [getUserProvider].
  const GetUserProviderFamily();

  /// See also [getUserProvider].
  GetUserProviderProvider call({
    bool updateState = false,
  }) {
    return GetUserProviderProvider(
      updateState: updateState,
    );
  }

  @override
  GetUserProviderProvider getProviderOverride(
    covariant GetUserProviderProvider provider,
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
  String? get name => r'getUserProviderProvider';
}

/// See also [getUserProvider].
class GetUserProviderProvider
    extends AutoDisposeFutureProvider<List<UserModel2>> {
  /// See also [getUserProvider].
  GetUserProviderProvider({
    bool updateState = false,
  }) : this._internal(
          (ref) => getUserProvider(
            ref as GetUserProviderRef,
            updateState: updateState,
          ),
          from: getUserProviderProvider,
          name: r'getUserProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserProviderHash,
          dependencies: GetUserProviderFamily._dependencies,
          allTransitiveDependencies:
              GetUserProviderFamily._allTransitiveDependencies,
          updateState: updateState,
        );

  GetUserProviderProvider._internal(
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
    FutureOr<List<UserModel2>> Function(GetUserProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserProviderProvider._internal(
        (ref) => create(ref as GetUserProviderRef),
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
  AutoDisposeFutureProviderElement<List<UserModel2>> createElement() {
    return _GetUserProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserProviderProvider && other.updateState == updateState;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, updateState.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserProviderRef on AutoDisposeFutureProviderRef<List<UserModel2>> {
  /// The parameter `updateState` of this provider.
  bool get updateState;
}

class _GetUserProviderProviderElement
    extends AutoDisposeFutureProviderElement<List<UserModel2>>
    with GetUserProviderRef {
  _GetUserProviderProviderElement(super.provider);

  @override
  bool get updateState => (origin as GetUserProviderProvider).updateState;
}

String _$getUserOneProviderHash() =>
    r'9c0fb76048e45ab8158d5a21723557a1969bf678';

/// See also [getUserOneProvider].
@ProviderFor(getUserOneProvider)
const getUserOneProviderProvider = GetUserOneProviderFamily();

/// See also [getUserOneProvider].
class GetUserOneProviderFamily extends Family<AsyncValue<List<UserModel2>>> {
  /// See also [getUserOneProvider].
  const GetUserOneProviderFamily();

  /// See also [getUserOneProvider].
  GetUserOneProviderProvider call({
    bool updateState = false,
    required bool isUpdate,
  }) {
    return GetUserOneProviderProvider(
      updateState: updateState,
      isUpdate: isUpdate,
    );
  }

  @override
  GetUserOneProviderProvider getProviderOverride(
    covariant GetUserOneProviderProvider provider,
  ) {
    return call(
      updateState: provider.updateState,
      isUpdate: provider.isUpdate,
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
  String? get name => r'getUserOneProviderProvider';
}

/// See also [getUserOneProvider].
class GetUserOneProviderProvider
    extends AutoDisposeFutureProvider<List<UserModel2>> {
  /// See also [getUserOneProvider].
  GetUserOneProviderProvider({
    bool updateState = false,
    required bool isUpdate,
  }) : this._internal(
          (ref) => getUserOneProvider(
            ref as GetUserOneProviderRef,
            updateState: updateState,
            isUpdate: isUpdate,
          ),
          from: getUserOneProviderProvider,
          name: r'getUserOneProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserOneProviderHash,
          dependencies: GetUserOneProviderFamily._dependencies,
          allTransitiveDependencies:
              GetUserOneProviderFamily._allTransitiveDependencies,
          updateState: updateState,
          isUpdate: isUpdate,
        );

  GetUserOneProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.updateState,
    required this.isUpdate,
  }) : super.internal();

  final bool updateState;
  final bool isUpdate;

  @override
  Override overrideWith(
    FutureOr<List<UserModel2>> Function(GetUserOneProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserOneProviderProvider._internal(
        (ref) => create(ref as GetUserOneProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        updateState: updateState,
        isUpdate: isUpdate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserModel2>> createElement() {
    return _GetUserOneProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserOneProviderProvider &&
        other.updateState == updateState &&
        other.isUpdate == isUpdate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, updateState.hashCode);
    hash = _SystemHash.combine(hash, isUpdate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserOneProviderRef on AutoDisposeFutureProviderRef<List<UserModel2>> {
  /// The parameter `updateState` of this provider.
  bool get updateState;

  /// The parameter `isUpdate` of this provider.
  bool get isUpdate;
}

class _GetUserOneProviderProviderElement
    extends AutoDisposeFutureProviderElement<List<UserModel2>>
    with GetUserOneProviderRef {
  _GetUserOneProviderProviderElement(super.provider);

  @override
  bool get updateState => (origin as GetUserOneProviderProvider).updateState;
  @override
  bool get isUpdate => (origin as GetUserOneProviderProvider).isUpdate;
}

String _$updateUserHash() => r'6e59b5b763842dd17a519c7ac65e225df87c1edc';

/// See also [UpdateUser].
@ProviderFor(UpdateUser)
final updateUserProvider =
    AutoDisposeNotifierProvider<UpdateUser, bool>.internal(
  UpdateUser.new,
  name: r'updateUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateUser = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
