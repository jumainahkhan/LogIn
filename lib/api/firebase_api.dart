import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance.ref(destination);

      // Create a task to upload the file
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return null;
    }
  }
}
