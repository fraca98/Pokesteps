import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokesteps/notifiers/LoginPrefs.dart';
import 'package:pokesteps/screen/HomePage.dart';
import 'package:pokesteps/screen/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //to perform await/async in main

  SharedPreferences? prefs =
      await SharedPreferences.getInstance(); //import sharedpreferences
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  MyApp(this.prefs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness
          .dark, //set icons of statusBar to black (cause transparent statusBar(white))
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginPrefs>(
          create: (context) => LoginPrefs(prefs),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginPage.route,
        routes: {
          LoginPage.route: (context) => LoginPage(),
          HomePage.route: (context) => HomePage(),
        },
      ),
    );
  }
}
