import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokesteps/database/database.dart';
import 'package:pokesteps/database/entities/EggTable.dart';
import 'package:pokesteps/database/entities/PokemonTable.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'Egg.dart';


class GeneratePokemon extends ChangeNotifier{
  var rnd_id;
  Egg? responsePokeApi; //initally is assumed to be null the first time i open the app
  bool firstEverEgg = true; //to manage the callPokeApi the first time ever: no Egg in the database

  AppDatabase database;
  GeneratePokemon(this. database){ //Constructor for GeneratePokemon
    //print('GeneratePokemon constructor start');
    _init().then((_){ //defined cause i want to use an async constructor: do _init() --> then perform other things
      //print('GeneratePokemon constructor end');
    });

  }

  Future<void> _init() async{ //Use it to manage database (need await)

    EggTable? last = await database.eggdao.lastEgg(); //take the last egg
    //print('last: $last');
    //print(jsonEncode(last)); //to see value encode to Json

    if (last == null || last.openegg == true){ //i have not yet the egg (Not pressed the button) -> egg not present or last egg open
    }
    else{ //else i have the egg in the table
      PokemonTable? existPokemon = await database.pokemonDao.pokemonInfoId(last.id); //check if in the table pokemon i have the info of the last egg
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
    rnd_id = Random().nextInt(898) + 1;
    //print('generateid function: ${rnd_id}'); //prind id random of pokemon generated
  }

  Future<void> onRestartcallPokeApi(EggTable last) async { //retrieve pokemon info on restart of the app if not present in the PokemonTable
    while(responsePokeApi == null) {
      //print('before');
      responsePokeApi = await Apicalls().fetchEgg(last.id); //keep callApi until i get a valid response
      //print('after');   
    }  
    /*print(responsePokeApi);
    print(responsePokeApi!.toJson());*/  //or //print(jsonEncode(responsePokeApi!));

    await database.pokemonDao.insertPokemon(PokemonTable(id: responsePokeApi!.id, name: responsePokeApi!.name, hatchcounter: responsePokeApi!.hatchcounter));
    //print('the Pokemon has been added to the table');

    /*List<PokemonTable>? respoke = await database.pokemonDao.findAllPokemon(); //print Pokemon table
    print('all_pokemon: ${jsonEncode(respoke)}'); //encode in json to see list of Pokemon*/

    notifyListeners(); 
  }

  Future<void> callPokeApi() async { //the call of the Api when i press the button in the app (NOT ON RESTART)
    //print('calledPokeApi');

    //print(EggTable(autoid: null, id:  rnd_id, openegg: false));
    //print(EggTable(autoid: null, id:  rnd_id, openegg: false).toJson()); //toJson to see egg

    await database.eggdao.insertEgg(EggTable(autoid: null, id: rnd_id, openegg: false)); //! cause i'm sure that responsePokeApi is not null
    //print('the Egg has been added to the table');

    /*List<EggTable>? res = await database.eggdao.findAllEggs(); //print Egg table
    print('all_eggs: ${jsonEncode(res)}'); //encode in json to see list of Egg*/

    PokemonTable? existPokemon = await database.pokemonDao.pokemonInfoId(rnd_id);
    //print('existPokemon: ${jsonEncode(existPokemon)}'); 

    //if my pokemon exists in the database don't call the Api but reload it
    if (existPokemon == null){ //if the pokemon is not stored --> i need to collect and save these info in the PokemonTable
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
    else{
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

    /*List<EggTable>? res = await database.eggdao.findAllEggs(); //print Egg table
    print('all_eggs: ${jsonEncode(res)}'); //encode in json to see list of Egg*/

  }

  Future<void> clearEgg() async{
    rnd_id = null; //remove the rnd_id defined
    responsePokeApi = null; //to reset the value of responsePokeApi when i have to get a new egg
  }

  int get getStepstoHatch => 255*(responsePokeApi!.hatchcounter + 1);


}
