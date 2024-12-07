import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_suscrip.g.dart';
@riverpod

Future<List<SuscribeModel>> getSuscribeProvider(GetSuscribeProviderRef ref,
    {bool updateState = true}) {
  final api = SuscribeApi();
  return api.getSuscribes();
}

@riverpod
class UpdateSuscribe extends _$UpdateSuscribe {
  @override
  bool build() {
    return true;
  }

  void change() {
    state = !state;
  }
}