import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
Future<List<CategoryModel>> getCategoriesProvider(
  GetCategoriesProviderRef ref,
) {
  final api = ApiCategory();
  return api.getCategories();
}

@riverpod
class ModelCategory extends _$ModelCategory {
  @override
  CategoryModel build() {
    return CategoryModel();
  }

  void setCategory(CategoryModel category) {
    state = category;
  }
}
