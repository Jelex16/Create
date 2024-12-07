import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_home_client/models/models.dart';

class ApiLocation {
  Future<List<StateModel>> getStates() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('estados')
        .orderBy('nameState', descending: false)
        .get();
    return querySnapshot.docs.map((doc) {
      return StateModel(
        id: doc.id,
        nameState: doc['nameState'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  }

  Future<List<MunicipalityModel>> getMunicipalities(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('municipios')
        .where('idFk', isEqualTo: id)
        .orderBy('createdAt')
        .get();
    return querySnapshot.docs.map((doc) {
      return MunicipalityModel(
        id: doc.id,
        nameMuni: doc['nameMuni'],
        idFk: doc['idFk'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  }

  Future<List<ColoniesModel>> getColonies(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('colonias')
        .where('idFk', isEqualTo: id)
        .orderBy(
          'createdAt',
        )
        .get();
    return querySnapshot.docs.map((doc) {
      return ColoniesModel(
        id: doc.id,
        nameColo: doc['nameColo'],
        idFk: doc['idFk'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  }
}
