import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokesteps/database/database.dart';
import 'package:pokesteps/database/entities_db/EggTable.dart';
import 'package:pokesteps/database/entities_db/PokemonTable.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'entities/Egg.dart';


class GeneratePokemon extends ChangeNotifier{
  var rnd_id; //declare the variable for the random id of the Egg/Pokémon
  Egg? responsePokeApi; //initally is assumed to be null the first time i open the app
  final int numberpk = 898; //Number of Pokémon

  AppDatabase database;
  GeneratePokemon(this. database){ //Constructor for GeneratePokemon
    //print('GeneratePokemon constructor start');
    _init().then((_){ //defined cause i want to use an async constructor: do _init() --> then perform other things
    //print('GeneratePokemon constructor end');
    });
  }

  Future<void> _init() async{ //Use it to manage database (need await) and when i re-open the app

    EggTable? last = await database.eggdao.lastEgg(); //take the last egg in EggTable
    //print('last: $last');
    //print('last: ${jsonEncode(last)}'); //to see value encode to Json

    if (last == null || last.openegg == true){ //i have not the egg (Not pressed the button) -> egg not present (EggTable is empty) or last egg is open
      //do nothing
    }
    else{ //else i have the egg in the table
      PokemonTable? existPokemon = await database.pokemonDao.pokemonInfoId(last.id); //check if in the PokemonTable i have the info of the last egg
      //print('existPokemon: ${jsonEncode(existPokemon)}');

      if (existPokemon!=null){ //i have the info of the pokemon -> so just reload it in responsePokeApi
        //print('I have info of Pokemon');
        responsePokeApi = Egg(id: existPokemon.id, name: existPokemon.name, hatchcounter: existPokemon.hatchcounter);
        //print('responsePokeApi: ${jsonEncode(responsePokeApi)}');
        notifyListeners();
      }
      else{ //if i have NOT the info of the pokemon -->i need to retrieve these info from the Api
        //print('I have NOT info of Pokemon');
        await onRestartcallPokeApi(last);
      }
    }
  }

  Future<void> generateid() async { //generate a random id for the pokemon
    rnd_id = Random().nextInt(numberpk) + 1;
    //print('generateid function: ${rnd_id}'); //prind id random of pokemon generated
  }

  Future<void> onRestartcallPokeApi(EggTable last) async { //retrieve pokemon info on restart of the app if not present in the PokemonTable
    //print('onRestartcallPokeApi');
    while(responsePokeApi == null) {
      //print('before');
      responsePokeApi = await Apicalls().fetchEgg(last.id); //keep callApi until i get a valid response
      //print('after');   
    }  
    /*print(responsePokeApi);
    print(responsePokeApi!.toJson());*/  //or //print(jsonEncode(responsePokeApi!));

    await database.pokemonDao.insertPokemon(PokemonTable(id: responsePokeApi!.id, name: responsePokeApi!.name, hatchcounter: responsePokeApi!.hatchcounter));
    //print('the Pokémon has been added to the table');

    /*List<PokemonTable>? respoke = await database.pokemonDao.findAllPokemon(); //print Pokemon table
    print('all_pokemon: ${jsonEncode(respoke)}'); //encode in json to see list of Pokemon*/

    notifyListeners(); 
  }

  Future<void> callPokeApi() async { //the call of the Api when i press the button in the app (NOT ON RESTART)
    //print('calledPokeApi');

    //print(EggTable(autoid: null, id:  rnd_id, openegg: false));
    //print(EggTable(autoid: null, id:  rnd_id, openegg: false).toJson()); //toJson to see egg

    //first i add the EggTable entity to its table
    await database.eggdao.insertEgg(EggTable(autoid: null, id: rnd_id, openegg: false)); //! cause i'm sure that responsePokeApi is not null
    //print('the Egg has been added to the table');

    /*List<EggTable>? totegg = await database.eggdao.findAllEggs(); //print Egg table
    //print('all_eggs: ${jsonEncode(totegg)}'); //encode in json to see list of Egg*/

    PokemonTable? existPokemon = await database.pokemonDao.pokemonInfoId(rnd_id); //check if info of Pokemon exists with rnd_id of my last created Egg(closed)
    //print('existPokemon: ${jsonEncode(existPokemon)}'); 

    if (existPokemon == null){ //if the pokemon is not stored (existPokemon==null) --> i need to collect and save these info in the PokemonTable
      while(responsePokeApi == null) {
        //print('before');
        responsePokeApi = await Apicalls().fetchEgg(rnd_id); //keep callApi until i get a valid response
        //print('after');      
      }
     /*print(responsePokeApi);
     print(responsePokeApi!.toJson());*/  //or //print(jsonEncode(responsePokeApi!));

      await database.pokemonDao.insertPokemon(PokemonTable(id: responsePokeApi!.id, name: responsePokeApi!.name, hatchcounter: responsePokeApi!.hatchcounter));
      //print('the Pokemon has been added to the table');

      /*List<PokemonTable>? respoke = await database.pokemonDao.findAllPokemon(); //print Pokemon table
      print('all_pokemon: ${jsonEncode(respoke)}'); //encode in json to see list of Pokemon*/
    
    }
    else{  //if my pokemon exists in the database don't call the Api but reload it
      responsePokeApi = Egg(id: rnd_id, name: existPokemon.name, hatchcounter: existPokemon.hatchcounter); //ricreate responsePokeApi
      //print(jsonEncode(responsePokeApi));
    }

    notifyListeners();
  }

  Future<void> updateopenlastegg() async{ //update the last Egg in the table to openegg: true
    EggTable? eggtoup = await database.eggdao.lastEgg();
    eggtoup!.openegg = true; //set to true openegg
    await database.eggdao.updatelastopenegg(eggtoup); //update the last egg as open in the database
    //print('updated last egg as open');

    /*List<EggTable>? totegg = await database.eggdao.findAllEggs(); //print Egg table
    print('all_eggs: ${jsonEncode(totegg)}'); //encode in json to see list of Egg*/

  }

  Future<void> clearIdResponse() async{
    rnd_id = null; //remove the rnd_id defined
    responsePokeApi = null; //to reset the value of responsePokeApi when i have to get a new egg
  }

  int get getStepstoHatch => 255*(responsePokeApi!.hatchcounter + 1);


}
