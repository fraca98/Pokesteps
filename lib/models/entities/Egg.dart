//The COMPLETE Egg model when i get the response from the PokéApi
class Egg{
  
  final int id;
  final String name;
  final int hatchcounter;

  Egg({
    required this.id,
    required this.name,
    required this.hatchcounter,
  });

  //This factory method is used to create a new Egg object from a JSON.
  factory Egg.fromJson(Map<String, dynamic> json) {
    return Egg(
      id: json['id'],
      name: json['name'],
      hatchcounter: json['hatch_counter'],
    );
  }//Egg.fromJson

  //Encode to JSON
  Map <String, dynamic> toJson() => {

    'id': id,
    'name': name,
    'hatch_counter': hatchcounter,
  };
  
}//Egg