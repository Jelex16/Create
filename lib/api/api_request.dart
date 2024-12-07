import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_home_client/models/models.dart';

import '../shared/widgets/widgets.dart';

class ApiRequest {
  Future<List<ValuesPrices>> getValues() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('valores')
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      return ValuesPrices(
        id: doc.id,
        value1: doc['value1'],
        value2: doc['value2'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  }

  Future<void> addRequest(OfferCreateModel model, List<String> municipalities,
      List<String> colonies, List<OfferCreateModel> offers) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final id = auth.currentUser?.uid;
    String collection = 'request';
    List<String> listsMatchOffers =
        addlistMatch(offers, model, municipalities, colonies);
    await FirebaseFirestore.instance.collection(collection).doc(model.id).set({
      'uidUser': id,
      'isSale': model.isSale,
      'isOffer': model.isOffer,
      'estado': model.estado?.value,
      'municipios': municipalities,
      'colonias': colonies,
      'precio': model.precio?.value,
      'category': model.category,
      'createdAt': DateTime.now().toString(),
      'offers': listsMatchOffers,
      'atendidos': model.atendidos,
      'baneados': model.baneados,
      'metrosCuadrados': model.metrosCuadrados ?? '0',
      //'mensual': model.mensual ?? 0
      'opcYesorNot': model.attributo2?.value
    });
  }

  Future<List<RequestModel>> getRequest({bool allData = false}) async {
    QuerySnapshot querySnapshot;

    if (allData) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('request')
          .orderBy('createdAt', descending: true)
          .get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('request')
          .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('createdAt', descending: true)
          .get();
    }
    return querySnapshot.docs.map((doc) {
      return RequestModel(
        id: doc.id,
        category: doc['category'],
        isSale: doc['isSale'],
        isOffer: doc['isOffer'],
        estado: doc['estado'],
        municipios: List<String>.from(doc['municipios']),
        colonias: List<String>.from(doc['colonias']),
        precio: doc['precio'],
        createdAt: doc['createdAt'],
        uidUser: doc['uidUser'],
        offers: List<String>.from(doc['offers']),
        atendidos: (doc['atendidos'] == null || doc['atendidos'].isEmpty)
            ? null
            : List<String>.from(doc['atendidos']),
        baneados: (doc['baneados'] == null || doc['baneados'].isEmpty)
            ? null
            : List<String>.from(doc['baneados']),
        metrosCuadrados: doc['metrosCuadrados'],
        // mensual: doc['mensual'],
        opcYesorNot: doc['opcYesorNot'],
      );
    }).toList();
  }

  Future<List<RequestModel>> getRequestUpdate() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('request')
        .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy('createdAt')
        .get();
    return querySnapshot.docs.map((doc) {
      return RequestModel(
        id: doc.id,
        offers: List<String>.from(doc['offers']),
      );
    }).toList();
  }
}
