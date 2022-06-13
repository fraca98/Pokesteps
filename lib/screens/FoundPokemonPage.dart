import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokesteps/models/StepsCall.dart';
import 'package:pokesteps/screens/RootPage.dart';
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
  void initState() {
    //_asyncmethod();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //first build the page, then perform these methods (so i get no error when i set to null responsePokeApi)
      //print("WidgetsBinding");
      _asyncmethod();
    });
  }

  _asyncmethod() async {
    await Provider.of<TakeEgg>(context, listen: false)
        .updateWalkEgg(); //i want to take a new egg (TakeEgg provider)
    await Provider.of<GeneratePokemon>(context, listen: false)
        .clearEgg(); //to reset value contained in response of PokeApi
    await Provider.of<StepsCall>(context, listen: false)
        .clearSumSteps(); //clear sumsteps when i want to take a new egg*/
    await Future.delayed(Duration(seconds: 4)).then(
      (value) => Navigator.pushReplacementNamed(context, RootPage.route),
    ); //await 5 seconds and then push me to RootPage (no possibility to go back)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Set background color of scaffold to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have found ${toBeginningOfSentenceCase(Provider.of<GeneratePokemon>(context, listen: false).responsePokeApi!.name)}', //use intl to set first letter of pokemon name to uppercase
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 450,
              width: 450,
              child: CachedNetworkImage(
                imageUrl:
                    'https://raw.githubusercontent.com/fraca98/sprites/master/sprites/pokemon/other/home/${Provider.of<GeneratePokemon>(context, listen: false).responsePokeApi!.id}.png',
                placeholder: (context, url) => Pokeloader(),
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/errorpsyduck.png',
                        fit: BoxFit.contain),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ops, Psyduck has lost the image',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Text(
              '#ID ${Provider.of<GeneratePokemon>(context, listen: false).responsePokeApi!.id}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
