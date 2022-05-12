import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/models/TakeEgg.dart';

class PokemonPage extends StatefulWidget {
  //StetafulWidget
  const PokemonPage({Key? key}) : super(key: key);

  static const route = '/pokemonpage/';
  static const routename = 'PokemonPage';

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return _eggdisplay(context);
  }

  Widget _eggdisplay(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<TakeEgg>(
          builder: (context, value, child) => Text(
            //Consumer to rebuild only this widget
            Provider.of<TakeEgg>(context, listen: false)
                    .WalkEgg //set listen: false cause i want to get this value without rebuilding all after
                ? 'Walk to hatch this Pokémon egg' //if _WalkEgg is true (i have an egg: i want to hatch the egg)
                : 'You have found a Pokémon egg', //if _WalkEgg is false (i have NOT an egg: i want to take the egg)
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Image.asset(
            'assets/images/pokemonegg.png',
            fit: BoxFit
                .contain, //fill the image container as large as possible keeping dimensions of the image (no distorsion)
          ),
          height: 300, //define the height of the container
          width: 300,
        ),
        Consumer<TakeEgg>(
          //rebuild only this widget with Consumer
          builder: (context, value, child) => Container(
              height: 200,
              child: Center(
                child: Provider.of<TakeEgg>(context, listen: false)
                        .WalkEgg //want only to get the value to build, not rebuid all
                    ? _barsteps(context)
                    : _newEgg(
                        context), //if _WalkEgg true display bar, else the button _newEgg
              )),
        ),
      ],
    );
  }

  Widget _newEgg(BuildContext context) {
    //The button to take the new egg
    return ElevatedButton(
      onPressed: () async {
        Provider.of<TakeEgg>(context, listen: false).updateWalkEgg();
      },
      child: Text(
        'Take this Pokémon egg',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        elevation: 10,
      ),
    );
  }

  Widget _barsteps(BuildContext context) {
    //to put with FITBIT API CALLS
    return Text(
        'Here i have to put the bar, buttons for fetch of steps and to go to FoundPokemonPage');
  }
}
