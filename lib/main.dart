import 'package:flutter/material.dart';
import 'package:pokesteps/screen/WelcomePage.dart';
import 'package:pokesteps/screen/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.route,
      routes: {
        WelcomePage.route: (context) => WelcomePage(),
        LoginPage.route: (context) => LoginPage(),
      },
    );
  }
}
