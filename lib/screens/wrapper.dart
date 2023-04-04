import 'package:campus_market/screens/home_screen.dart';
import 'package:campus_market/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    //return either home signin
    if (user == null) {
      return SignInScreen();
    }else{
      return HomeScreen();
    }
  }
}
