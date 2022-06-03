import 'package:flutter/material.dart';
import 'package:pokesteps/icons/pokeicons_icons.dart'; //Custom icons for BottomNavigationBar
import 'package:pokesteps/screens/PokemonPage.dart';
import 'package:pokesteps/screens/PokedexPage.dart';
import 'package:pokesteps/screens/TrainerPage.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  static const route = '/rootpage/';
  static const routename = 'RoutePage';

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final PageController _pageController = PageController(); //control of PageView
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Set background color of scaffold to white
      body: _getBody(),
      bottomNavigationBar: _getFooter(),
    );
  }

  Widget _getBody() {
    //Define the body of the Scaffold based on BottomNavigationBar model provider
    return PageView(
      controller: _pageController,
      children: const [
        PokemonPage(), //0
        PokedexPage(), //1
        TrainerPage(), //2
      ],
      onPageChanged: (index) {
        setState(() {
          selectedindex = index;
        });
      },
    );
  }

  Widget _getFooter() {
    //Define the BottomNavigationBar
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, //Fixed BottomNavigationBar
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 255, 0, 0),
      unselectedItemColor: Colors.black,

      iconSize: 50,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pikachu), label: 'Pokémon'),
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pokedex), label: 'Pokédex'),
        BottomNavigationBarItem(
            icon: Icon(Pokeicons.pokehat), label: 'Trainer'),
      ],
      currentIndex: selectedindex,
      onTap: (index){
        selectedindex = index;
        _pageController.animateToPage(selectedindex, duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
    );
  }
}
