import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/home_screen.dart';
import 'package:campus_market/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final UserRepo _auth = UserRepo();

  String email = '';
  String password = '';

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  get onChanged => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign In",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
      Colors.blueGrey, Colors.red])),
        child:SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height* 0.2, 20, 30),
            child: Form(
            child: Column(
              children: [
                //made all Sized box constructors const's
                const SizedBox(height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline,
                    false, _emailTextController, onChanged: (val){
                  setState(() => email = val

                  );
                    }),
                const SizedBox(height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline,
                    true, _passwordTextController, onChanged: (val){
                      setState(() => password = val
                      );

                          }),
                const SizedBox(height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(email:
                  _emailTextController.text, password:
                  _passwordTextController.text).then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
              ],
            ),
            ),
          ),
        )

    ),
    );
  }

  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
          style: TextStyle(color: Colors.white60),),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen())

            );
          },

          child: const Text(" Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


