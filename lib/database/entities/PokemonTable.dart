//Pokemon model when i put it in the database
import 'package:floor/floor.dart';

@Entity(
  tableName: 'PokemonTable',
)
class PokemonTable{
  @PrimaryKey()
  final int id;
  
  final String name;
  final int hatchcounter;
  

  PokemonTable({
    required this.id,
    required this.name,
    required this.hatchcounter,  
  });

  //This factory method is used to create a new PokemonDatabase object from a JSON.
  factory PokemonTable.fromJson(Map<String, dynamic> json) {
    return PokemonTable(
      id: json['id'],
      name: json['name'],
      hatchcounter: json['hatchcounter'],
    );
  }//PokemonDatabase.fromJson

  //Encode to JSON
  Map <String, dynamic> toJson() => { //called with jsonEncode
    'id': id,
    'name': name,
    'hatchcounter': hatchcounter,
  };
  
}//PokemonDatabase