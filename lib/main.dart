import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; //To use SystemChrome:set notification bar color, icons notification bar color...
import 'package:pokesteps/screens/RootPage.dart';
import 'package:pokesteps/screens/FoundPokemonPage.dart';
import 'package:pokesteps/models/BottomNavigationBarIndex.dart'; //Provider model for BottomNavigationBar
import 'package:pokesteps/models/TakeEgg.dart';
import 'package:pokesteps/models/GeneratePokemon.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); //to perform await/async in main
  SharedPreferences? prefs;
  prefs = await SharedPreferences.getInstance(); //import sharedpreferences

  runApp(MyApp(prefs));

}

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  MyApp(this.prefs, {Key? key}) : super(key: key);

  @override //This widget is the root of the application.
  Widget build(BuildContext context) {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, //Set notification top bar color to white
      statusBarIconBrightness: Brightness.dark, // For Android set dark icons
      statusBarBrightness: Brightness.light, // For iOS set dark icons
    ),
  );

    return MultiProvider(
      //ChangeNotifierProvider for BottomNavigationBar index
      providers: [
        ChangeNotifierProvider<BottomNavigationBarIndex>(create: (context) => BottomNavigationBarIndex()),
        ChangeNotifierProvider<TakeEgg>(create: (context) => TakeEgg(prefs)),
        ChangeNotifierProvider<GeneratePokemon>(create: (context) => GeneratePokemon(prefs)),
        ChangeNotifierProvider<StepsCall>(create: (context) => StepsCall(prefs)),
      ],
      child: MaterialApp(
        title: 'pokesteps',
        theme: ThemeData(
          primaryColor: Colors.white, //set primary color to white, also for app theme visualization linked to the app of the icon
        ),
        initialRoute: RootPage.route,
        routes: {
          RootPage.route: (context) => RootPage(),
          FoundPokemonPage.route: (context) => FoundPokemonPage(),
        },
      ),
    );
  }
}
