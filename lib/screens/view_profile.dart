import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Profile Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        )
      ),

      body: Container(
          decoration: const BoxDecoration(gradient:
          LinearGradient(colors: [Colors.blueGrey, Colors.red])),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,
                  MediaQuery.of(context).size.height * 0.2, 20, 30),
            ),
          ),
      ),
    );
  }
}
