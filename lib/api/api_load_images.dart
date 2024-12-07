import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ApiLoadImages {
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    for (File image in images) {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}.${image.path.split('.').last}';
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}
