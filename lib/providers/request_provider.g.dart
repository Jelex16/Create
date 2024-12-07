// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRequestHash() => r'4894b39f560120e82d93a01a35b2177060ed59f5';

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

/// See also [getRequest].
@ProviderFor(getRequest)
const getRequestProvider = GetRequestFamily();

/// See also [getRequest].
class GetRequestFamily extends Family<AsyncValue<List<RequestModel>>> {
  /// See also [getRequest].
  const GetRequestFamily();

  /// See also [getRequest].
  GetRequestProvider call({
    bool isUpdate = false,
  }) {
    return GetRequestProvider(
      isUpdate: isUpdate,
    );
  }

  @override
  GetRequestProvider getProviderOverride(
    covariant GetRequestProvider provider,
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
  String? get name => r'getRequestProvider';
}

/// See also [getRequest].
class GetRequestProvider extends AutoDisposeFutureProvider<List<RequestModel>> {
  /// See also [getRequest].
  GetRequestProvider({
    bool isUpdate = false,
  }) : this._internal(
          (ref) => getRequest(
            ref as GetRequestRef,
            isUpdate: isUpdate,
          ),
          from: getRequestProvider,
          name: r'getRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRequestHash,
          dependencies: GetRequestFamily._dependencies,
          allTransitiveDependencies:
              GetRequestFamily._allTransitiveDependencies,
          isUpdate: isUpdate,
        );

  GetRequestProvider._internal(
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
    FutureOr<List<RequestModel>> Function(GetRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRequestProvider._internal(
        (ref) => create(ref as GetRequestRef),
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
  AutoDisposeFutureProviderElement<List<RequestModel>> createElement() {
    return _GetRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRequestProvider && other.isUpdate == isUpdate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isUpdate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetRequestRef on AutoDisposeFutureProviderRef<List<RequestModel>> {
  /// The parameter `isUpdate` of this provider.
  bool get isUpdate;
}

class _GetRequestProviderElement
    extends AutoDisposeFutureProviderElement<List<RequestModel>>
    with GetRequestRef {
  _GetRequestProviderElement(super.provider);

  @override
  bool get isUpdate => (origin as GetRequestProvider).isUpdate;
}

String _$isUpdateRequestHash() => r'c46112debf604651d50987175efbfaffb8cc3edf';

/// See also [IsUpdateRequest].
@ProviderFor(IsUpdateRequest)
final isUpdateRequestProvider =
    AutoDisposeNotifierProvider<IsUpdateRequest, bool>.internal(
  IsUpdateRequest.new,
  name: r'isUpdateRequestProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUpdateRequestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsUpdateRequest = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
