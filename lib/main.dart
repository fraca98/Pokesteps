import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; //To use SystemChrome:set notification bar color, icons notification bar color...
import 'screens/RootPage.dart';
import 'screens/FoundPokemonPage.dart';
import 'package:pokesteps/models/BottomNavigationBarIndex.dart'; //Provider model for BottomNavigationBar
import 'package:pokesteps/models/TakeEgg.dart'; //Provider model for TakeEgg (if i have a new egg management)
import 'package:pokesteps/models/GeneratePokemon.dart'; //Provider for the PokeApi call and generation of new pokémon
import 'package:pokesteps/models/StepsCall.dart'; //Provider for fetching data from fibit and manage number of steps to hatch the egg

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
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
    return MultiProvider(
      providers: [ //The provider
        ChangeNotifierProvider<BottomNavigationBarIndex>(create: (context) => BottomNavigationBarIndex()),
        ChangeNotifierProvider<TakeEgg>(create: (context) => TakeEgg()),
        ChangeNotifierProvider<GeneratePokemon>(create: (context) => GeneratePokemon()),
        ChangeNotifierProvider<StepsCall>(create: (context) => StepsCall()),
      ],
      child: MaterialApp(
        title: 'pokesteps',
        theme: ThemeData(
          primaryColor: Colors
              .white, //Set primary color to white (linked also to app icon when i press on the square of the bottom bar)
        ),
        initialRoute: RootPage.route,
        routes: {
          RootPage.route: (context) => const RootPage(),
          FoundPokemonPage.route: (context) => const FoundPokemonPage(),
        },
      ),
    );
  }
}
