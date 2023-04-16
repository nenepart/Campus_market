import 'package:campus_market/firebase_options.dart';
import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final UserRepo _userRepo = UserRepo();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<UserRepo>.value(
        value: _userRepo,
        child: MaterialApp(
          home: Wrapper(
            userRepo: _userRepo,
          ),
        ));
  }
}
