import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
      Colors.blueGrey])),
        SizedBox (
          height: 30,
        )
        SizedBox(
          height: 30,
        ),
        reusableTextField("Enter UserName", Icons.person_outline, false,
          _emailTextController),
        SizedBox(
          height: 20,
        ),
        reusableTextField("Enter Password", Icons.lock_outline, true,
          _passwordTextController),
        signInSignUpButton(context, true, () {})
    ),
    );
  }
}
