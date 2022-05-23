import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Egg.dart';


class GeneratePokemon extends ChangeNotifier{
  var rnd_id;
  Egg? responsePokeApi; //initally is assumed to be null the first time i open the app


  SharedPreferences? prefs;
  GeneratePokemon(this.prefs){ //Constructor for GeneratePokemon
    rnd_id = prefs?.getInt('rnd_id'); //restore value of rnd_id if present, else will be null
    //print(rnd_id);

    var todoString = prefs?.getString('responsePokeApi'); //to get possible value stored of PokeApi
    //print(todoString);
    if (todoString != null){ //if i have for sure a value stored i want to restore value of responsePokeApi
      //print(jsonDecode(todoString));
      //print(Egg.fromJson(jsonDecode(todoString)));
      responsePokeApi = Egg.fromJson(jsonDecode(todoString)); //to get Egg instance i need to decode the Json saved in sharedpreferences
    }
    else{
      if (rnd_id !=null){ //if i have not rnd_id that means that i pressed the button, but something went wrong when calling pokeApi (so i want to get this info first)
        callPokeApi();
      }
    }
    //print(responsePokeApi);

  }




  void generateid() async { //generate a random id for the pokemon
    rnd_id = Random().nextInt(898) + 1;
    await prefs?.setInt('rnd_id',rnd_id);
    //print(rnd_id); //prind id random of pokemon generated
  }

  Future<void> callPokeApi() async {
    while(responsePokeApi == null) {
      //print('before');
      responsePokeApi = await Apicalls().fetchEgg(rnd_id); //keep callApi until i get a valid response
      //print('after');      
    }

    //print(responsePokeApi);
    //print(jsonEncode(responsePokeApi!.toJson())); //assure not null with !
    await prefs?.setString('responsePokeApi',jsonEncode(responsePokeApi!.toJson())); //assure not null with ! (i have for sure response since i exit for cycle if not null)
    //i need to encode responsePokeApi in Json to save it in sharepreferences as String

    notifyListeners();
    //print('notified');
  }

  Future<void> clearPokeApi() async {
    responsePokeApi = null; //to reset the value of responsePokeApi when i have to get a new egg
    await prefs?.remove('responsePokeApi'); //remove responsePokeApi from storage
  }

  Future<void> clearnd_id() async{
    rnd_id = null;
    await prefs?.remove('rnd_id');
  }

  Egg? get getResponsePokeApi => responsePokeApi; //get the response value of PokeApi
  int get getrnd_id => rnd_id; //get value of rnd_id generated
  int get getHatchCounter => responsePokeApi!.hatchcounter; //acces hatchcounter retrieved from PokeApi (!: it can be null-->non nullable)
  String get getName => responsePokeApi!.name; //acces name retrieved from PokeApi (!: it can be null-->non nullable)
  int get getStepstoHatch => 255*(responsePokeApi!.hatchcounter + 1);


}
