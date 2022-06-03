import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokesteps/database/database.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/entities/Egg.dart';


class GeneratePokemon extends ChangeNotifier{
  var rnd_id;
  Egg? responsePokeApi; //initally is assumed to be null the first time i open the app

  AppDatabase database;
  SharedPreferences? prefs;
  GeneratePokemon(this. database, this.prefs){ //Constructor for GeneratePokemon
    print('GeneratePokemon constructor start');
    _init().then((_){ //defined cause i want to use an async constructor: do _init() --> then perform other things
      print('GeneratePokemon constructor end');
    });

  }

  Future<void> _init() async{ //Use it to manage possible values saved in prefs and database (manage the state of the app)
    //print('rend_id: ${rnd_id}); //for sure null here
    rnd_id = prefs?.getInt('rnd_id'); //restore value of rnd_id if present, else will be null
    print('rnd_id prefs: ${rnd_id}');

    if (rnd_id == null){ //rnd_id null: not pressed button to take new egg
    }
    else{
      Egg? last = await database.eggdao.lastEgg(); //get the instance of 'Egg' of last Egg inserted in table Egg
      //print('last: ${last}');
      //print('lastencode: ${jsonEncode(last)}');
      if (last != null && last.openegg == false){ //if i have a value stored (last egg) i want to restore value of responsePokeApi from the last egg. I need to check if the last egg inserted is open(i have not already inserted my last egg) or not(it's correctly my last egg inserted)
        responsePokeApi = last;
        print(jsonEncode(responsePokeApi));
        print('restore value of responsePokeApi');

        //to check Egg table if last egg taken is correct
        List<Egg>? res = await database.eggdao.findAllEggs(); //print Egg table
        print('all_eggs: ${jsonEncode(res)}'); //encode in json to see list of Egg*/

        notifyListeners(); //notify that responsePokeApi changed -->no more null, so i can display stepsbar

      }
      else{ //if i have rnd_id (so pressed button), but responsePokeApi null
        print('constructor call PokeApi');
        await callPokeApi();
      }
    }
    //print(responsePokeApi);
  }




  Future<void> generateid() async { //generate a random id for the pokemon
    rnd_id = Random().nextInt(898) + 1;
    await prefs?.setInt('rnd_id',rnd_id);
    print('generateid function: ${rnd_id}'); //prind id random of pokemon generated
  }

  Future<void> callPokeApi() async {
    print('calledPokeApi');
    while(responsePokeApi == null) {
      //print('before');
      responsePokeApi = await Apicalls().fetchEgg(rnd_id); //keep callApi until i get a valid response
      //print('after');      
    }

    /*print(responsePokeApi);
    print(responsePokeApi!.toJson());
    print(jsonEncode(responsePokeApi!.toJson())); //assure not null with !*/

    await database.eggdao.insertEgg(responsePokeApi!); //! cause i'm sure that responsePokeApi is not null
    print('the Egg has been added to the table');

    List<Egg>? res = await database.eggdao.findAllEggs(); //print Egg table
    print('all_eggs: ${jsonEncode(res)}'); //encode in json to see list of Egg*/

    responsePokeApi = await database.eggdao.lastEgg(); //get responsePokeApi now from the saved in database to have also the idtable not null
    print('responsePokeApi from callPokeApi (not null idtable): ${jsonEncode(responsePokeApi)}');

    notifyListeners();
  }

  Future<void> updateopenlastegg() async{
    print('before open: ${jsonEncode(responsePokeApi)}'); //to see the actual responsePokeApi
    responsePokeApi!.openegg = true; //set openegg in responsePokeApi as true-->means the egg is open, to update the database (table Egg)
    print('after open: ${jsonEncode(responsePokeApi)}'); //see the updated responsePokeApi after open egg
    await database.eggdao.updatelastopenegg(responsePokeApi!); //update the last egg as open in the database
    print('updated last egg as open');

    List<Egg>? res = await database.eggdao.findAllEggs(); //print Egg table
    print('all_eggs: ${jsonEncode(res)}'); //encode in json to see list of Egg*/
  }

  Future<void> clearEgg() async{
    rnd_id = null; //remove the rnd_id defined
    responsePokeApi = null; //to reset the value of responsePokeApi when i have to get a new egg
    await prefs?.remove('rnd_id');
  }

  Egg? get getResponsePokeApi => responsePokeApi; //get the response value of PokeApi
  int get getrnd_id => rnd_id; //get value of rnd_id generated
  int get getHatchCounter => responsePokeApi!.hatchcounter; //acces hatchcounter retrieved from PokeApi (!: it can be null-->non nullable)
  String get getName => responsePokeApi!.name; //acces name retrieved from PokeApi (!: it can be null-->non nullable)
  int get getStepstoHatch => 255*(responsePokeApi!.hatchcounter + 1);


}
