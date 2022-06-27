import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pokesteps/database/entities_db/EggTable.dart';
import 'package:pokesteps/database/entities_db/PokemonTable.dart';
import '../database/database.dart';

class PokeTrainerProvider extends ChangeNotifier{
  late int numberdiscovered; //number of Pokemon in the Pokedex (discovered --> opened unique Egg)
  List<EggTable>? distinctOpenEggTable; //list of Egg in EggTable distint and opened
  List<PokemonTable>? pokemondatable; //list containing all Pokémon saved in the PokemonTable (database)
  AppDatabase database;

  PokeTrainerProvider(this.database){
    numberdiscovered = -1; //initially when initialized the constructor of provider (on start of the app) set it to -1 --> i show the loader (check when calling PokeLoader in the screens of Pokedex and TrainerPage)

    _init().then((_){});
  }

  Future<void> _init() async{
    await updatenumberpokedex();
  }

  Future<void> updatenumberpokedex() async{
  //print('updatenumberpokedex poketrainer provider');

  distinctOpenEggTable = await database.eggdao.getnumberinpokedex(); //retrieve the distinct and opened Egg in EggTable
  //print('distinctOpenEggTable: ${jsonEncode(distinctOpenEggTable)}');
  numberdiscovered = distinctOpenEggTable?.length ?? 0; //if null-->length:0
  //print('numberdiscovered: $numberdiscovered'); //number of unique Egg(Pokémon) discovered

  pokemondatable = await database.pokemonDao.findAllPokemon(); //retrieve all Pokemon from PokemonTable
  //print(jsonEncode(pokemondatable)); //in Json to see all the Pokémons in PokemonTable

  notifyListeners();
  }

  Future<void> showLoader() async{ //to show the loader i set number discovered -1 (as defined in the logic of the page affected)
    numberdiscovered = -1;
    notifyListeners();
  }

  Future<void> deleteallEggData()async{ //to delete all the data (EggTable) (so clear also the Pokédex, the number of discovered Pokémon...)
    await database.eggdao.deleteAllEgg();
    await showLoader(); //i want to show the loader when refreshing all
    await updatenumberpokedex();
  }

}