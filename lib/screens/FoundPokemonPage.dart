import 'package:flutter/material.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:pokesteps/widget/pokeloader.dart';
import 'package:provider/provider.dart';
import '../models/GeneratePokemon.dart';
import '../models/TakeEgg.dart';
import 'package:intl/intl.dart';

class FoundPokemonPage extends StatefulWidget {
  const FoundPokemonPage({Key? key}) : super(key: key);

  static const route = '/foundpokemonpage/';
  static const routename = 'FoundPokemonPage';

  @override
  State<FoundPokemonPage> createState() => _FoundPokemonPageState();
}

class _FoundPokemonPageState extends State<FoundPokemonPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //deactivate go back button of the phone to avoid bug with navigator
      child: Scaffold(
        backgroundColor:
            Colors.white, //Set background color of scaffold to white
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have found ${toBeginningOfSentenceCase(Provider.of<GeneratePokemon>(context, listen: false).getName)}', //use intl to set first letter of pokemon name to uppercase
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 450,
                width: 450,
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${Provider.of<GeneratePokemon>(context, listen: false).getrnd_id}.png',
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child; //while loading
                    return Center(
                      child: Pokeloader(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/errorpsyduck.png',
                        fit: BoxFit.contain),
                        SizedBox(height: 10,),
                        Text('Ops, Psyduck has lost the image', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<TakeEgg>(context, listen: false)
                      .updateWalkEgg(); //i want to take a new egg (TakeEgg provider)
                  Navigator.pop(context); //Go back to the previous page
                  Provider.of<GeneratePokemon>(context, listen: false)
                      .clearPokeApi(); //to reset value contained in response of PokeApi
                  Provider.of<StepsCall>(context, listen: false)
                      .clearSumSteps(); //clear sumsteps when i want to take a new egg
                },
                child: Text(
                  "Let's search a new egg",
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
