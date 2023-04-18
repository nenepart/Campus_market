import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestoreInstance;

  DatabaseService() : _firestoreInstance = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getCollection(String path) {
    return _firestoreInstance.collection(path).get().then(
          (value) => value.docs,
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocument(String path) {
    try {
      return _firestoreInstance.doc(path).get();
    } catch (exception) {
      print("document does not exist for path: $path error: $exception");
      return Future.value(null);
    }
  }

  Future<String?> createDocument(String collectionPath, Map<String, dynamic> json, {String? docId}) {
    DocumentReference docRef = _firestoreInstance.collection(collectionPath).doc(docId);
    return docRef.set(json).then((value) => docRef.id, onError: (error) {
      print("An error occured: ${error}");
      return "";
    });
  }

  Future<bool> deleteDocument(String docPath) {
    return _firestoreInstance.doc(docPath).delete().then((value) => true).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> updateDocument(String documentPath, Map<String, dynamic> data) =>
      _firestoreInstance.doc(documentPath).update(data).then((value) => true).onError((error, stackTrace) {
        return false;
      });

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(String collectionPath) {
    return _firestoreInstance.collection(collectionPath).snapshots();
  }

  CollectionReference<Map<String, dynamic>> getCollectionReference(String collectionPath) {
    return _firestoreInstance.collection(collectionPath);
  }
}
