import 'package:campus_market/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserRepo userRepo;

  @override
  Widget build(BuildContext context) {
    userRepo = context.watch();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Market'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await userRepo.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blueGrey, Colors.red])),
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
