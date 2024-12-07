import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<List<UserModel2>> getUserProvider(GetUserProviderRef ref,
    {bool updateState = false}) {
  final api = ApiUser();
  return api.getUsers();
}

@riverpod
Future<List<UserModel2>> getUserOneProvider(GetUserOneProviderRef ref,
    {bool updateState = false, required bool isUpdate}) {
  final api = ApiUser();
  return api.getUser();
}

@riverpod
class UpdateUser extends _$UpdateUser {
  @override
  bool build() {
    return true;
  }

  void change() {
    state = !state;
  }
}