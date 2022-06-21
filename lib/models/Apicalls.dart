import 'package:http/http.dart' as http;
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
}