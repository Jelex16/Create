import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_home_client/models/models.dart';

class ApiCategory {
  Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      return CategoryModel(
        id: doc.id,
        name: doc['name'],
        attribute1: doc['attribute1'],
        attribute2: doc['attribute2'],
        createdAt: doc['createdAt'],
      );
    }).toList();
  }
}
