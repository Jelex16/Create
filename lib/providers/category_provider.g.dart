// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCategoriesProviderHash() =>
    r'580027cd27b581e14650e30c56e91f86bd491073';

/// See also [getCategoriesProvider].
@ProviderFor(getCategoriesProvider)
final getCategoriesProviderProvider =
    AutoDisposeFutureProvider<List<CategoryModel>>.internal(
  getCategoriesProvider,
  name: r'getCategoriesProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCategoriesProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCategoriesProviderRef
    = AutoDisposeFutureProviderRef<List<CategoryModel>>;
String _$modelCategoryHash() => r'46c118e8223d5d3b59abd941736a08dfad551ab0';

/// See also [ModelCategory].
@ProviderFor(ModelCategory)
final modelCategoryProvider =
    AutoDisposeNotifierProvider<ModelCategory, CategoryModel>.internal(
  ModelCategory.new,
  name: r'modelCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$modelCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ModelCategory = AutoDisposeNotifier<CategoryModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
