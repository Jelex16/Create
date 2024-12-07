// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getOfferingHash() => r'6baff5fe2e278b5422b3db0e4617cd0c54c836f3';

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

/// See also [getOffering].
@ProviderFor(getOffering)
const getOfferingProvider = GetOfferingFamily();

/// See also [getOffering].
class GetOfferingFamily extends Family<AsyncValue<List<OfferCreateModel>>> {
  /// See also [getOffering].
  const GetOfferingFamily();

  /// See also [getOffering].
  GetOfferingProvider call({
    bool isUpdate = false,
  }) {
    return GetOfferingProvider(
      isUpdate: isUpdate,
    );
  }

  @override
  GetOfferingProvider getProviderOverride(
    covariant GetOfferingProvider provider,
  ) {
    return call(
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
  String? get name => r'getOfferingProvider';
}

/// See also [getOffering].
class GetOfferingProvider
    extends AutoDisposeFutureProvider<List<OfferCreateModel>> {
  /// See also [getOffering].
  GetOfferingProvider({
    bool isUpdate = false,
  }) : this._internal(
          (ref) => getOffering(
            ref as GetOfferingRef,
            isUpdate: isUpdate,
          ),
          from: getOfferingProvider,
          name: r'getOfferingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOfferingHash,
          dependencies: GetOfferingFamily._dependencies,
          allTransitiveDependencies:
              GetOfferingFamily._allTransitiveDependencies,
          isUpdate: isUpdate,
        );

  GetOfferingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isUpdate,
  }) : super.internal();

  final bool isUpdate;

  @override
  Override overrideWith(
    FutureOr<List<OfferCreateModel>> Function(GetOfferingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOfferingProvider._internal(
        (ref) => create(ref as GetOfferingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isUpdate: isUpdate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OfferCreateModel>> createElement() {
    return _GetOfferingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOfferingProvider && other.isUpdate == isUpdate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isUpdate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOfferingRef on AutoDisposeFutureProviderRef<List<OfferCreateModel>> {
  /// The parameter `isUpdate` of this provider.
  bool get isUpdate;
}

class _GetOfferingProviderElement
    extends AutoDisposeFutureProviderElement<List<OfferCreateModel>>
    with GetOfferingRef {
  _GetOfferingProviderElement(super.provider);

  @override
  bool get isUpdate => (origin as GetOfferingProvider).isUpdate;
}

String _$offerCreateHash() => r'6df29b7734561fd27b1537db8617948ce37b7e18';

/// See also [OfferCreate].
@ProviderFor(OfferCreate)
final offerCreateProvider =
    AutoDisposeNotifierProvider<OfferCreate, OfferCreateModel>.internal(
  OfferCreate.new,
  name: r'offerCreateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$offerCreateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfferCreate = AutoDisposeNotifier<OfferCreateModel>;
String _$isOffertingHash() => r'b695889171a1fdca99c61342800048019cead4af';

/// See also [IsOfferting].
@ProviderFor(IsOfferting)
final isOffertingProvider =
    AutoDisposeNotifierProvider<IsOfferting, bool>.internal(
  IsOfferting.new,
  name: r'isOffertingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isOffertingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsOfferting = AutoDisposeNotifier<bool>;
String _$isUpdateOfferingHash() => r'aabcc835f8c5fa5eebe90b378fcb49f7d02f4940';

/// See also [IsUpdateOffering].
@ProviderFor(IsUpdateOffering)
final isUpdateOfferingProvider =
    AutoDisposeNotifierProvider<IsUpdateOffering, bool>.internal(
  IsUpdateOffering.new,
  name: r'isUpdateOfferingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUpdateOfferingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsUpdateOffering = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
