import 'package:floor/floor.dart';
import 'package:pokesteps/database/entities/Egg.dart';

//This class defines a dao
@dao
abstract class EggDao {

  //SELECT -> this allows to obtain all the entries of the Egg table
  @Query('SELECT * FROM Egg')
  Future<List<Egg>> findAllEggs();

  //INSERT --> this allows to insert an Egg in the table
  @insert
  Future<void> insertEgg(Egg egg);

  //SELECT -> this allows to obtain the last egg insert in the Egg table
  @Query('SELECT * FROM Egg ORDER BY idtable DESC LIMIT 1')
  Future<Egg?> lastEgg();

  //UPDATE -> set openegg of lastegg to true(opened)
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatelastopenegg(Egg updatelastopenegg);
  
}