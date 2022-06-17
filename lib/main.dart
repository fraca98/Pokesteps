import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/notifiers/Identity_Notifier.dart';
import 'package:pokesteps/notifiers/Identity_Notifier_SignUp.dart';
import 'package:pokesteps/screen/SignUpPage.dart';
import 'package:pokesteps/screen/LoginPage.dart';
import 'package:pokesteps/screen/PrivacyPolicyPage.dart';
import 'package:pokesteps/screen/TermsConditions.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IdentityNotifier()),
        ChangeNotifierProvider(create: (context) => IdentityNotifierSignUp()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (context) => LoginPage(),
        SignUpPage.route: (context) => SignUpPage(),
        PrivacyPolicyPage.route: (context) => PrivacyPolicyPage(),
        TermsConditionsPage.route: (context) => TermsConditionsPage(),
      },
    );
  }
}
