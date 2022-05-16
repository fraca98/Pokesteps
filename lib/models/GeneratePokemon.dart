import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokesteps/models/Apicalls.dart';
import 'Egg.dart';


class GeneratePokemon extends ChangeNotifier{
  var rnd_id;
  Egg? responsePokeApi;

  void generateid() { //generate a random id for the pokemon
    rnd_id = Random().nextInt(898) + 1;
    //print(rnd_id); //prind id random of pokemon generated
  }

  Future<Egg?> callPokeApi() async {
    responsePokeApi = await Apicalls().fetchEgg(rnd_id);
    //print(rnd_id);
    //responsePokeApi == null ? print('Null') : print('I have all from fetchEgg');
    notifyListeners();
    return null;
  }

  void clearPokeApi(){
    responsePokeApi = null; //to reset the value of responsePokeApi when i have to get a new egg
  }

  Egg? get getResponsePokeApi => responsePokeApi; //get the response value of PokeApi
  int get getrnd_id => rnd_id; //get value of rnd_id generated
  int get getHatchCounter => responsePokeApi!.hatchcounter; //acces hatchcounter retrieved from PokeApi (!: it can be null)
  String get getName => responsePokeApi!.name; //acces name retrieved from PokeApi (!: it can be null)
  int get getStepstoHatch => 255*(responsePokeApi!.hatchcounter + 1); //calculate the number of steps from hatch_counter (formula indicated on PokéApi)(!: it can be null)


}
