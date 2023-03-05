import 'package:campus_market/navigation/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final RouterWrapper _router = RouterWrapper();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routingInfoParser,
    );
  }
}
