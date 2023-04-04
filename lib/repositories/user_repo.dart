import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase


  // auth change user stream
  /*Stream<User> get user{
    return _auth.signInWithEmailAndPassword(email: email, password: password)
    .map(())
  }
*/


  Future signInWithEmail(String email, String password) async {
    //use firebaseAuth to sign in
    //if successful, use the firebase auth id returned from the user credential; to pull the user data from firestore
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
    }

  Future signUpWithEmail(String email, String password, UserModel model) async {
    //use firebaseAuth to sign in
    //if successful, use the id returned to create a new document in firestore and save the user data there
    //store the user data here also
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

  }

  //sign out
Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}

