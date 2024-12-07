import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:match_home_client/models/models.dart';

class ApiAuth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> updatePassword(String password) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await user.updatePassword(password);
      }
      return {'success': true, 'message': 'Contraseña actualizada'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          'success': false,
          'message': 'La contraseña es demasiado débil'
        };
      } else if (e.code == 'requires-recent-login') {
        return {
          'success': false,
          'message':
              'Para cambiar la contraseña, debes iniciar sesión de nuevo'
        };
      } else {
        return {'success': false, 'message': e.toString()};
      }
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return {
        'user': user,
        'success': true,
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {
          'user': null,
          'success': false,
          'message': 'Usuario no encontrado'
        };
      }
      if (e.code == 'invalid-credential') {
        return {
          'user': null,
          'success': false,
          'message': 'Contraseña o email incorrectos'
        };
      }
      return {'user': null, 'success': false, 'message': e.message};
    }
  }

  sendresetPasswordEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  signOut() async {
    await auth.signOut();
  }

  //delete user account
  Future<Map<String, dynamic>> deleteUser() async {
    try {
      await auth.currentUser!.delete();
      return {'success': true, 'message': 'Cuenta eliminada'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return {
          'success': false,
          'message': 'Se requiere inicio de sesión reciente'
        };
      }
      return {'success': false, 'message': e.message};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // sendSignInLinkToEmail(String email, ActionCodeSettings actionCodeSettings) async {
  //   await auth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
  // }

  //user is signed in
  bool isSignedIn() {
    return auth.currentUser != null;
  }

  Future<UserModel?> getDataUser(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return UserModel.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>,
          id: querySnapshot.docs.first.id);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> checkStatus() async {
    if (isSignedIn()) {
      UserModel? user = await getDataUser(auth.currentUser!.uid);
      if (user != null) {
        UserModel.instance().setData(user);
      }
      return {'success': true, 'user': user};
    } else {
      UserModel.instance().resetData();
      return {'success': false, 'user': null};
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String email, String password) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {'user': user, 'success': true, 'message': 'Registro exitoso'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          'success': false,
          'message': 'La contraseña es demasiado débil'
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'message': 'El correo electrónico ya está en uso'
        };
      } else {
        return {'success': false, 'message': 'Error al registrar usuario'};
      }
    }
  }

  Future<void> addUser(UserModelRegister user, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(user.id).set({
      'urlProfile': user.urlProfile,
      'uid': uid,
      'name': user.name?.value,
      'phone': user.phone?.value,
      'inmobiliario': user.inmobiliario?.value,
      'ciudad': user.ciudad?.value,
      'urlAvatar': user.urlAvatar,
      'email': user.email?.value,
      'createdAt': DateTime.now().toIso8601String(),
      'isActive': false,
      'numberAdvertisement': 0,
      'nameAdvertisement': '',
    });
  }

// Resto del código...

  Future<String?> saveToken() async {
    final tokenNotifiation = await FirebaseMessaging.instance.getToken();
    return tokenNotifiation;
  }

  Future<void> saveTokenToDatabase() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final token = await saveToken();
    print('token: $token');
    final users = FirebaseFirestore.instance.collection('users');
    final userSnapshot = await users.where('uid', isEqualTo: userId).get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDoc = userSnapshot.docs.first;
      await userDoc.reference.update({'token': token});
    } else {
      print('No user found with the provided uid');
    }
  }

  Future<String> getUserAccessToken(String uid, {String role = 'root'}) async {
    final users = FirebaseFirestore.instance.collection('users');
    final userSnapshot = await users
        .where('uid', isEqualTo: uid)
        .where('role', isEqualTo: role)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDoc = userSnapshot.docs.first;
      return userDoc['token'];
    } else {
      throw Exception('No user found with the provided uid and role');
    }
  }

  Future<String> getUserUidRoot() async {
    final users = FirebaseFirestore.instance.collection('users');
    final userSnapshot = await users.where('role', isEqualTo: 'root').get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDoc = userSnapshot.docs.first;
      return userDoc['uid'];
    } else {
      throw Exception('No user found with the provided uid and role');
    }
  }

  Future<void> sendCode(String email) async {
    // final appCheckToken = await FirebaseAppCheck.instance.getToken();
    // print('appCheckToken: $appCheckToken');
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // Muestra un mensaje de éxito
    } catch (e) {
      print('Error al enviar el código de verificación: $e');
      // Maneja errores
    }
  }
}
