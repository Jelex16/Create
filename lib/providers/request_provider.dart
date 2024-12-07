import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_provider.g.dart';

@riverpod
Future<List<RequestModel>> getRequest(GetRequestRef ref,
    {bool isUpdate = false}) {
  final api = ApiRequest();
  return api.getRequest();
}

@riverpod
class IsUpdateRequest extends _$IsUpdateRequest {
  @override
  bool build() {
    return true;
  }

  void setIsUpdateRequest() {
    state = !state;
  }
}
