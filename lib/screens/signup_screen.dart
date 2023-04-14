import 'package:campus_market/models/user_model.dart';
import 'package:campus_market/reusable_widgets/reusable_widgets.dart';
import 'package:campus_market/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/user_repo.dart';
import 'home_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final UserRepo _auth = UserRepo();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  String location = '';
  String college = '';



  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
  TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
  TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _schoolTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();

  UserModel? get model => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blueGrey, Colors.red])
        ),
        child: Padding(
          //made the constructor a const
          padding:  const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Form(
            key: _formKey,
            child: ListView(
          children: [
          // made all sizedBox constructors const's
          const SizedBox(
          height: 20,
          ),
            reusableTextField("First Name", Icons.person,
                false, _firstNameTextController,
                _firstNameTextController.text.isEmpty ? 'Enter name' : null,
                    onChanged: (val) {
              //validator: (val) => val.isEmpty ? 'Enter name' : null;
                  setState(() => firstName = val);

                }),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Last Name", Icons.person, false,
                _lastNameTextController,
                _lastNameTextController.text.isEmpty ? 'Enter name': null,
                onChanged: (val) {
                 // validator: (val) => val.isEmpty ? 'Enter name' : null;
                  setState(() => lastName = val);

                }),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("College", Icons.school, false,
                _schoolTextController,
                _schoolTextController.text.isEmpty ? 'Enter College': null,
                onChanged: (val) {
                  setState(() => college = val);

                }),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Location", Icons.location_searching, false,
                _locationTextController,
                _locationTextController.text.isEmpty ? 'Enter location': null,
                onChanged: (val) {
                  setState(() => location = val);

                }),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Email", Icons.person_outline,
                false, _emailTextController,
                _emailTextController.text.isEmpty ? 'Enter email': null,
                onChanged: (val) {
                 // validator: (val) => val.isEmpty ? 'Enter an email' : null;
                  setState(() => email = val);

                }),
            const SizedBox(height: 20,
            ),
            reusableTextField("Password", Icons.lock_outline,
                true, _passwordTextController,
                _passwordTextController.text.isEmpty ? 'Enter password': null,
                //_passwordTextController.length < 6 ? 'Enter stronger password': null,
                onChanged: (val) {
                  //validator: (val) => val.length < 6 ? 'Enter stronger password' : null;
                  setState(() => password = val);

                }),
            const SizedBox(height: 20,
            ),
            reusableTextField("Confirm Password", Icons.lock_outline,
                true, _confirmPasswordTextController,
                _confirmPasswordTextController.text.isEmpty ? 'Enter password':
                null,
                onChanged: (val) {
                 // validator: (val) => val.length != _passwordTextController ?
                  //'password do not match' : null;
                  setState(() => password = val);
                }
            ),
            signInSignUpButton(context, false, () async {
              if(_formKey.currentState!.validate()){
                dynamic result = await _auth.signUpWithEmail(email, password, model!,);
                if (result == null)
                  {
                    setState(() => error = 'Please enter valid email.');
                  }
               }
            }


              //add verification after shit runs
              //firebase auth instance.
              //come check later
    /*
              FirebaseAuth.instance.createUserWithEmailAndPassword(email:
              _emailTextController.text, password:
              _passwordTextController.text).then((value) {
                print("Account created successful");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                    const HomeScreen()));
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
              */
            }),


            goBackOption()

            ],

                ),
          ),
        ),
      ),
    );
  }
  Row goBackOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Go",
          style: TextStyle(color: Colors.white60),),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen())

            );
          },

          child: const Text(" Back",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
