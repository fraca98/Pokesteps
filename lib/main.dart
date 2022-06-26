import 'package:flutter/material.dart';
import 'package:pokesteps/models/LoginPrefs.dart';
import 'package:pokesteps/models/PokeTrainerProvider.dart';
import 'package:pokesteps/screens/DetailPokemon.dart';
import 'package:pokesteps/screens/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; //To use SystemChrome:set notification bar color, icons notification bar color...
import 'package:pokesteps/screens/RootPage.dart';
import 'package:pokesteps/screens/FoundPokemonPage.dart';
import 'package:pokesteps/models/TakeEgg.dart';
import 'package:pokesteps/models/GeneratePokemon.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //to perform await/async in main

  SharedPreferences? prefs = await SharedPreferences.getInstance(); //import sharedpreferences

  print('logged: ${prefs.getBool('logged')}');
  print(prefs.getString('email'));
  print(prefs.getString('password'));

  final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build(); //This opens the database

  runApp(MyApp(database, prefs));
}

class MyApp extends StatelessWidget {
  AppDatabase database;
  SharedPreferences prefs;
  MyApp(this.database, this.prefs, {Key? key}) : super(key: key);

  @override //This widget is the root of the application.
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( //change the style of the statusBar
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, //set icons of statusBar to black (cause transparent statusBar, it's white)
    ));

    return MultiProvider(
      providers: [ //Providers required to manage the state of the app
        ChangeNotifierProvider<TakeEgg>(create: (context) => TakeEgg(prefs)),
        ChangeNotifierProvider<GeneratePokemon>(
            create: (context) => GeneratePokemon(database)),
        ChangeNotifierProvider<StepsCall>(
            create: (context) => StepsCall(prefs)),
        ChangeNotifierProvider<PokeTrainerProvider>(
            create: (context) => PokeTrainerProvider(database)),
        ChangeNotifierProvider<LoginPrefs>(
            create: (context) => LoginPrefs(prefs)),
      ],
      child: MaterialApp(
        title: 'pokesteps',
        theme: ThemeData(
          primaryColor: Colors
              .white, //set primary color to white, also for app theme visualization linked to the app of the icon
        ),

        initialRoute: prefs.getBool('logged') == true ? RootPage.route : LoginPage.route, //if i'm logged display RootPage else LoginPage
        routes: {
          LoginPage.route: (context) => LoginPage(),
          RootPage.route: (context) => RootPage(),
          FoundPokemonPage.route: (context) => FoundPokemonPage(),
          DetailPokemon.route: (context) => DetailPokemon(),
        },
      ),
    );
  }
}
