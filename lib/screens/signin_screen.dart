import 'package:campus_market/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
      Colors.blueGrey])),
        child:SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height* 0.2, 20, 30),
            child: Column(
              children: [
                SizedBox(height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline,
                    false, _emailTextController),
                SizedBox(height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline,
                    true, _passwordTextController),
                SizedBox(height: 20,
                ),
                signInSignUpButton(context, true, () {}),
                signUpOption(),
              ],
            ),
          ),
        )

    ),
    );
  }
}

Row signUpOption(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account?",
        style: TextStyle(color: Colors.white60),),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpScreen()));
         //Navigator.push(context,
             //MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: const Text(" Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
