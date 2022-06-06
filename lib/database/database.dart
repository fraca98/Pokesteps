//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Importing the entities and the daos of the database
import 'daos/eggDao.dart';
import 'entities/Egg.dart';

part 'database.g.dart'; // the generated code will be there


//Here we are saying that this is the first version of the Database and it has just 1 entity, EggDao (my table)
@Database(version: 1, entities: [Egg])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  EggDao get eggdao;
}//AppDatabase