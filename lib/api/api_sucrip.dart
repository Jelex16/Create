import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_home_client/models/models.dart';

class SuscribeApi{
  
  Future <List<SuscribeModel>>getSuscribes() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('suscripciones')
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      return SuscribeModel(
        id: doc.id,
        name: doc['name'],
        price: doc['price'],
        cantidad: doc['cantidad'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  } 
}