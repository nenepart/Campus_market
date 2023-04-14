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
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String error = '';

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  get onChanged => null;

  get model => null;

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
              key: _formKey,
              child: Column(
              children: [
                //made all Sized box constructors const's
                const SizedBox(height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline,
                    false, _emailTextController,
                    _emailTextController.text.isEmpty ? 'Enter name': null,
                    onChanged: (val){
                  setState(() => email = val

                  );
                    }),
                const SizedBox(height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline,
                    true, _passwordTextController,
                    _passwordTextController.text.isEmpty ? 'Enter name': null,
                    onChanged: (val){
                      setState(() => password = val
                      );

                          }),
                const SizedBox(height: 20,
                ),
                signInSignUpButton(context, true, () async {

                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signUpWithEmail(email, password, model);
                    if (result == null)
                   {
                      setState(() => error = 'Could not sign in with credentials');
                    }
                  }
                  
                  FirebaseAuth.instance.signInWithEmailAndPassword(email:
                  _emailTextController.text, password:
                  _passwordTextController.text).then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        const HomeScreen()));
                  }).onError((error, stackTrace) {
                    debugPrint("Error ${error.toString()}");
                  });
                }),

                const SizedBox(height: 12.0,),
                Text(
                  error,
                  style: const TextStyle(color: Colors.white60, fontSize: 14.0),
                ),
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


