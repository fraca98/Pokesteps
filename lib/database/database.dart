//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Importing the entities and the daos of the database
import 'package:pokesteps/database/entities_db/EggTable.dart';
import 'package:pokesteps/database/entities_db/PokemonTable.dart';
import 'daos/eggDao.dart';
import 'package:pokesteps/database/daos/pokemonDao.dart';

part 'database.g.dart'; // the generated code will be there


//Here we are saying that this is the first version of the Database and entities
@Database(version: 1, entities: [EggTable, PokemonTable])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  EggDao get eggdao;
  PokemonDao get pokemonDao;
  
}//AppDatabase