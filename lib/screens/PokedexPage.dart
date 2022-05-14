import 'package:flutter/material.dart';


import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';



class PokedexPage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PokedexPage> {

  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  
  //late List pokedex;
  List pokedex;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Stack(
        children: [
               
          Positioned(
            top: 55,
            left: 130,
            child: Text("pokedex", 
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),)
            ),
          Positioned(
            top: 100,
            bottom: 0,
            width: width,
            child: Column(
            children: [
              pokedex != null ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                ), itemCount: pokedex.length,
                  itemBuilder: (context, index){
                    var type = pokedex[index]['type'];
                   return Padding(
                     padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
                     child: Container(
                       decoration: BoxDecoration(
                        color: type[0] == 'Grass' ? Colors.greenAccent : type[0] == 'Fire' ? Colors.red : type[0] == 'Water' ? Colors.blue
                        : type[0] == 'Poison' ? Colors.deepPurpleAccent : type[0] == 'Electric' ? Colors.amber : type[0] == 'Rock' ? Colors.grey
                        : type[0] == 'Ground' ? Colors.brown : type[0] == 'Psychic' ? Colors.indigo : type[0] == 'Fighting' ? Colors.orange
                        : type[0] == 'Bug' ? Colors.lightGreenAccent : type[0] == 'Ghost' ? Colors.deepPurple : type[0] == 'Normal' ? Colors.black26 : Colors.pink,
                         borderRadius: BorderRadius.all(Radius.circular(20)),
                       ),
                       child: Stack(
                         children:[                   
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text (
                                     pokedex[index]['name'],
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold, fontSize: 18,
                                       color: Colors.white
                                     ),
                                   ),
                               ],
                             ),
                             Positioned(
                               top: 50,
                               right: 10,
                               child: Container(                           
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 8.0, right:8.0, top: 4,bottom: 4),
                                   child: Text(
                                     type.join('\n'),
                                     style: TextStyle(
                                       color: Colors.white
                                     ),                               
                                   ),
                                 ),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   color: Colors.black12,
                                 ),
                               ), 
                              ),
                             
                              

                             Positioned(
                               bottom: 5,
                               left: 5,
                             child: CachedNetworkImage(imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${index+1}.png'),

                             height: 100,
                             ),
                           ],                  
                       ),
                     ),
                   );
                  }
                )
              ): Center(
                child: CircularProgressIndicator(),
              )
            ],
                  ),
          ),
        ],
      )
    );
  }

  void fetchPokemonData(){
    var url = Uri.https("raw.githubusercontent.com","Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if(value.statusCode == 200){
       var decodedJsonData = jsonDecode(value.body);
       //print(decodedJsonData);
       pokedex = decodedJsonData['pokemon'];
       //print(pokedex[0]['name']);
       setState(() {
        
      });
      }
      
    });
  }
}


//class PokedexPage extends StatelessWidget {
  //const PokedexPage({Key? key}) : super(key: key);

  //@override
  //Widget build(BuildContext context) {
    //return Center(child: Text('PokedexPage'));
  //}
//}
