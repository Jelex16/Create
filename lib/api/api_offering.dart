import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/validator/validator.dart';

import '../shared/widgets/widgets.dart';

class ApiOffering {
  Future<void> addOffering(
      OfferCreateModel model, List<RequestModel> listaReq) async {
    final user = UserModel.instance();
    FirebaseAuth auth = FirebaseAuth.instance;
    final id = auth.currentUser?.uid;
    String collection = 'offering';
    List<String> listsMachtRequet = addMatchRequit(listaReq, model);
    await FirebaseFirestore.instance.collection(collection).doc(model.id).set({
      'uidUser': id,
      'isSale': model.isSale,
      'isOffer': model.isOffer,
      'estado': model.estado?.value,
      'municipio': model.municipio?.value,
      'colonia': model.colonia?.value,
      'precio': model.precio?.value,
      'attributo1': model.attributo1?.value,
      'attributo2': model.attributo2?.value,
      'images': model.images,
      'token': user.token,
      'category': model.category,
      'createdAt': DateTime.now().toString(),
      'offers': listsMachtRequet,
      'atendidos': model.atendidos,
      'baneados': model.baneados
    });
  }

  Future<List<OfferCreateModel>> getOffering({bool allData = false}) async {
    QuerySnapshot querySnapshot;
    if (allData) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('offering')
          .orderBy('createdAt', descending: true)
          .get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('offering')
          .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('createdAt', descending: true)
          .get();
    }
    return querySnapshot.docs.map((doc) {
      return OfferCreateModel(
        id: doc.id,
        category: doc['category'],
        isSale: doc['isSale'],
        isOffer: doc['isOffer'],
        estado: GeneralField.dirty(doc['estado']),
        municipio: GeneralField.dirty(doc['municipio']),
        colonia: GeneralField.dirty(doc['colonia']),
        precio: NumberInput.dirty(doc['precio']),
        attributo1: GeneralField.dirty(doc['attributo1']),
        attributo2: GeneralField.dirty(doc['attributo2']),
        images: doc['images'] == null ? null : List<String>.from(doc['images']),
        uidUser: doc['uidUser'],
        offers: (doc['offers'] == null || doc['offers'].isEmpty)
            ? null
            : List<String>.from(doc['offers']),
        atendidos: (doc['atendidos'] == null || doc['atendidos'].isEmpty)
            ? null
            : List<String>.from(doc['atendidos']),
        baneados: (doc['baneados'] == null || doc['baneados'].isEmpty)
            ? null
            : List<String>.from(doc['baneados']),
      );
    }).toList();
  }
}
