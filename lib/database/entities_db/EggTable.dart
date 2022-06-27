//The Egg model (EggTable) when i put it in the database (only few fields for each Egg saved)
import 'package:floor/floor.dart';

@Entity(tableName: 'EggTable')
class EggTable{
  @PrimaryKey(autoGenerate: true)
  final int? autoid;
  
  final int id;
  bool openegg;

  EggTable({
    required this.autoid,
    required this.id,
    required this.openegg
  });

  //This factory method is used to create a new EggTable object from a JSON.
  factory EggTable.fromJson(Map<String, dynamic> json) {
    return EggTable(
      autoid: json['autoid'],
      id: json['id'],
      openegg: json['openegg'],
    );
  }//EggDatabase.fromJson

  //Encode to JSON
  Map <String, dynamic> toJson() => { //called with jsonEncode
    'autoid': autoid,
    'id': id,
    'openegg': openegg,
  };
  
}//EggDatabase