import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location.g.dart';

@riverpod
Future<List<StateModel>> getStatesProvider(
  GetStatesProviderRef ref,
) {
  final api = ApiLocation();
  return api.getStates();
}

@riverpod
Future<List<MunicipalityModel>> getMunicipalitiesProvider(
    GetMunicipalitiesProviderRef ref,
    {String? id}) {
  final api = ApiLocation();
  return api.getMunicipalities(id ?? '');
}

@riverpod
Future<List<ColoniesModel>> getColoniesProvider(GetColoniesProviderRef ref,
    {String? id}) {
  final api = ApiLocation();
  return api.getColonies(id ?? '');
}

@riverpod
class IdMunicipalities extends _$IdMunicipalities {
  @override
  String build() {
    return '';
  }

  void setIdMunicipalities(String id) {
    state = id;
  }
}

@riverpod
class IdColonies extends _$IdColonies {
  @override
  String build() {
    return '';
  }

  void setIdColonies(String id) {
    state = id;
  }
}
