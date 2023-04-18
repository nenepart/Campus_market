import 'package:campus_market/repositories/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserRepo {
  UserRepo() : _dbService = DatabaseService() {
    _auth.authStateChanges().listen((event) async {
      if (event == null) {
        signOut();
      } else {
        firestoreUserStream.value = await getFirestoreUser(event);
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService;
  static const String userCollectionPath = "users";

  ValueNotifier<UserModel?> firestoreUserStream = ValueNotifier(null);

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
    //return _auth.signInWithEmailAndPassword(email: email, password: password)
  }

  Future<UserModel?> getFirestoreUser(User user) async {
    return _dbService.getDocument("$userCollectionPath/${user.uid}").then((value) {
      if (value == null) {
        throw "UserDocumentError";
      }
      return UserModel.fromDocument(value.data()!, value.id);
    });
  }

  Future<bool> signInWithEmail(String email, String password) async {
    //use firebaseAuth to sign in
    //if successful, use the firebase auth id returned from the user credential; to pull the user data from firestore

    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    if (user == null) {
      return false;
    }

    //Set user
    firestoreUserStream.value = await getFirestoreUser(user);
    print("User value is  ${firestoreUserStream.value} ${firestoreUserStream.hasListeners}");
    return true;
    /*
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    }
    on FirebaseAuthException catch (e) {
      if (e.code == null) {return false;
      }else if (e.code == 'user-not-found'){
        return 'No user found for that email,';
      }else if (e.code == 'wrong-password'){
        return 'Wrong password provided for that user.';
      }else{
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
    */
  }

//signup user
  Future<bool> signUpWithEmail(String email, String password, UserModel model) async {
    //use firebaseAuth to sign in
    //if successful, use the id returned to create a new document in firestore and save the user data there
    //store the user data here also
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //Create a new user document in database
      await _dbService.createDocument(userCollectionPath, model.toJson(), docId: user!.uid);
      firestoreUserStream.value = await getFirestoreUser(user);

      return true;
      firestoreUserStream.value = model;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

/*
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password'){
        return 'The password provided is too weak';
      }else if (e.code == 'email-already-in-use'){
        return 'The account already exist for that email.';
      }else{
        return e.message;
      }
    }catch (e){
      return e.toString();
    }
*/
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
