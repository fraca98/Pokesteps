import 'package:http/http.dart' as http;
import 'package:pokesteps/models/entities/Detail.dart';
import 'dart:convert'; //for jsonDecode
import 'package:pokesteps/models/entities/Egg.dart';

class Apicalls{

  //This utility method is used to fetch the Egg pokemon data using the PokeAPI (pokemon-species-->to get hatch_counter)
  Future<Egg?> fetchEgg(int id) async {
    final url = 'https://pokeapi.co/api/v2/pokemon-species/$id/';
    try {
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      return response.statusCode == 200
          ? Egg.fromJson(jsonDecode(response.body)) //if response ok
          : null; //else get null
    }
    catch(err){ //if error from pokeApi (no internet connection for example)
      //print('err');
      return null;
    }
  }

  //This utility method is used to fetch the info of the Pokémon in the Pokédex data using the PokeAPI (pokemon)
  Future<Detail?> detailApi(int id) async {
  bool found = false;
  while (found == false) {
    try {
      final url = 'https://pokeapi.co/api/v2/pokemon/$id';
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      if (response.statusCode == 200) {
        found = true;
        //print('fine');
        return Detail.fromJson(jsonDecode(response.body));
        }
      } catch (err) {} //else error internet connection not present
    }
  }

}