import 'Egg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //for jsonDecode

class Apicalls{

  //This utility method is used to fetch the Egg pokemon data using the PokeAPI (pokemon-species-->to get hatch_counter)
  Future<Egg?> fetchEgg(int id) async {
    final url = 'https://pokeapi.co/api/v2/pokemon-species/$id/';
    final response = await http.get(Uri.parse(url));
    //print(response.body);
    return response.statusCode == 200
        ? Egg.fromJson(jsonDecode(response.body))
        : null;
  }

}