import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage and return its URL
  Future<String?> uploadFile(String path, File file) async {
    final Reference storageReference = _firebaseStorage.ref().child(path);
    final UploadTask uploadTask = storageReference.putData(await file.readAsBytes());
    final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
    if (uploadTask.snapshot.state == TaskState.success) {
      final String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } else {
      print('Error from image repo ${uploadTask.snapshot}');
      return null;
    }
  }

  // Delete a file from Firebase Storage using its URL
  Future<bool> deleteFile(String url) async {
    try {
      await _firebaseStorage.refFromURL(url).delete();
      return true;
    } catch (error) {
      print('Error from image repo $error');
      return false;
    }
  }
}
