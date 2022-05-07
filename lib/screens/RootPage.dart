import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/icons/pokeicons_icons.dart'; //Custom icons for BottomNavigationBar
import 'package:pokesteps/screens/PokemonPage.dart';
import 'package:pokesteps/screens/PokedexPage.dart';
import 'package:pokesteps/screens/TrainerPage.dart';
import 'package:pokesteps/models/BottomNavigationBarIndex.dart'; //Provider model for BottomNavigationBar

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'RoutePage';

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Set background color of scaffold to white
      body: _getBody(),
      bottomNavigationBar: _getFooter(),
    );
  }

  Widget _getBody() {
    //Define the body of the Scaffold based on the index of BottomNavigationBar model provider
    return IndexedStack(
      //Select only one child from children based on index
      index: Provider.of<BottomNavigationBarIndex>(context)
          .pageNow, //Not need to rebuild the widget, so not using consumer
      children: [
        PokemonPage(), //0 pageSelectionIndex BottomNavigationBar model provider
        PokedexPage(), //1 pageSelectionIndex BottomNavigationBar model provider
        TrainerPage(), //2 pageSelectionIndex BottomNavigationBar model provider
      ],
    );
  }

  Widget _getFooter() {
    //Define the BottomNavigationBar
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, //Fixed BottomNavigationBar
      backgroundColor: Colors.white,
      selectedItemColor: Color.fromARGB(255, 255, 0, 0),
      unselectedItemColor: Colors.black,

      iconSize: 50,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pikachu), label: 'Pokémon'),
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pokedex), label: 'Pokédex'),
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pokehat), label: 'Trainer'),
      ],
      currentIndex: Provider.of<BottomNavigationBarIndex>(context).pageNow,
      onTap: (int index) {
        //onTap: i change the body when i select an icon on the BottomNavigationBar
        Provider.of<BottomNavigationBarIndex>(context,
                listen:
                    false) //Not need to rebuild the widget, so not using consumer, just set action
            .updatePageSelection(index);
      },
    );
  }
}