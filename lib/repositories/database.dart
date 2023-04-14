import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({ required this.uid });

  //collection reference
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('Students');

  Future updateUserData(String firstName, String lastName, String college,
      String location) async {
    return await studentCollection.doc(uid).set({
      'first name': firstName,
      'last name': lastName,
      'campus': college,
      'location': location,
    });
  }
  //get student stream
Stream<QuerySnapshot> get students {
    return studentCollection.snapshots();
}
}