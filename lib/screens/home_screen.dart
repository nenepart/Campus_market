import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_market/repositories/user_repo.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepo _auth = UserRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Market'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions:  <Widget>[
          TextButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blueGrey, Colors.red])),
        /*child:  Center(
          child: ElevatedButton(
            child: const Text("Sign Out"),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                    const SignInScreen()));
              });
            },

          ),
        ),*/
      ),
    );
  }
}
