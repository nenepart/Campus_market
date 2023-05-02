import 'dart:developer';

import 'package:campus_market/models/user_model.dart';
import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/bottom_navigator_screen.dart';
import 'package:campus_market/screens/signin_screen.dart';
import 'package:campus_market/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key, required this.userRepo}) : super(key: key);

  final UserRepo userRepo;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    log("User repo: ${widget.userRepo.firestoreUserStream}");
    return ValueListenableBuilder(
      valueListenable: widget.userRepo.firestoreUserStream,
      builder: (BuildContext context, UserModel? value, Widget? child) {
        log("In Wrapper $value");
        //return either home signin
        if (value == null) {
          if (showSignIn) {
            return SignInScreen(goToSignUp: () {
              setState(() {
                showSignIn = false;
              });
            });
          } else {
            return SignUpScreen(goToSignUp: () {
              setState(() {
                showSignIn = true;
              });
            });
          }
        } else {
          showSignIn = true;
          return BottomNavigationScreen();
        }
      },
    );
  }
}
