import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; //To use SystemChrome:set notification bar color, icons notification bar color...
import 'screens/RootPage.dart';
import 'package:pokesteps/models/BottomNavigationBarIndex.dart'; //Provider model for BottomNavigationBar

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, //Set notification top bar color to white
      statusBarIconBrightness: Brightness.dark, // For Android set dark icons
      statusBarBrightness: Brightness.light, // For iOS set dark icons
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override //This widget is the root of the application.
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarIndex>(
      //ChangeNotifierProvider for BottomNavigationBar index
      create: (context) => BottomNavigationBarIndex(),
      child: MaterialApp(
        title: 'pokesteps',
        theme: ThemeData(
          primaryColor: Colors.white, //Set primary color to white (linked also to app icon when i press on the square of the bottom bar) 
        ),
        initialRoute: RootPage.route,
        routes: {
          RootPage.route: (context) => RootPage(),
        },
      ),
    );
  }
}
