//The Egg model
class Egg{
  final int id;
  final String name;
  final int hatchcounter;

  const Egg({
    required this.id,
    required this.name,
    required this.hatchcounter,
  });

  //This factory method is used to create a new Egg object from a JSON.
  factory Egg.fromJson(Map<String, dynamic> json) {
    return Egg(
      id: json['id'],
      name: json['name'],
      hatchcounter: json['hatch_counter']
    );
  }//Egg.fromJson
  
}//Egg