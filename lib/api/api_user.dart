import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_home_client/models/models.dart';

class ApiUser {
  Future<List<UserModel2>> getUsers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      return UserModel2.fromJson(doc.data() as Map<String, dynamic>, id: doc.id);
    }).toList();
  }

  Future<List<UserModel2>> getUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return UserModel2(
         id: doc.id,
         uid: doc['uid'],
         name: doc['name'],
         email: doc['email'],
         createdAt: doc['createdAt'],
         numberAdvertisement: doc['numberAdvertisement'],
         nameAdvertisement: doc['nameAdvertisement'],
         );
    }).toList();
  }
}