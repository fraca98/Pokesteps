import 'package:floor/floor.dart';
import 'package:pokesteps/database/entities/EggTable.dart';

//This class defines a dao
@dao
abstract class EggDao {

  //SELECT -> this allows to obtain all the entries of the Egg table
  @Query('SELECT * FROM EggTable')
  Future<List<EggTable>> findAllEggs();

  //INSERT --> this allows to insert an Egg in the table
  @insert
  Future<void> insertEgg(EggTable egg);

  //SELECT -> this allows to obtain the last egg insert in the Egg table
  @Query('SELECT * FROM EggTable ORDER BY autoid DESC LIMIT 1')
  Future<EggTable?> lastEgg();

  //UPDATE -> set openegg of lastegg to true(opened)
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatelastopenegg(EggTable updatelastopenegg);

}