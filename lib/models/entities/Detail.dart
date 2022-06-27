//The Detail of the Pokémon from call PokeApi (used for the DetailPokemon)
class Detail{
  
  final int id;
  final String name;
  final int height; //retrieved in decimeters
  final int weight; //retrieved in hectograms

  Detail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
  });

  //This factory method is used to create a new Detail object from a JSON.
  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      height: json['height'],
    );
  }//Detail.fromJson

  //Encode to JSON
  Map <String, dynamic> toJson() => {

    'id': id,
    'name': name,
    'weight': weight,
    'height': height,
  };
  
}//Detail