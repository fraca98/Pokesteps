import 'package:floor/floor.dart';
import 'package:pokesteps/database/entities_db/EggTable.dart';

//This class defines a dao
@dao
abstract class EggDao {

  //SELECT -> this allows to obtain all the entries of the EggTable
  @Query('SELECT * FROM EggTable')
  Future<List<EggTable>> findAllEggs();

  //INSERT --> this allows to insert an Egg in the EggTable
  @insert
  Future<void> insertEgg(EggTable egg);

  //SELECT --> this allows to obtain the last Egg insert in the EggTable
  @Query('SELECT * FROM EggTable ORDER BY autoid DESC LIMIT 1')
  Future<EggTable?> lastEgg();

  //UPDATE --> set openegg of lastegg to true(opened)
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatelastopenegg(EggTable updatelastopenegg);

  //QUERY --> the distinct Egg occurrences in EggTable that i have (opened unique Egg)
  @Query('SELECT DISTINCT id,openegg FROM EggTable WHERE openegg=1 ORDER BY id ASC') //retrieve id,name DISTINCT (to not have duplicated Pokemon) where openegg is true and order by id desc(1,2,3...) //openegg==1(true) for SQLite package
  Future<List<EggTable>> getnumberinpokedex(); //i don't specify idtable to be retrieved cause EggTable can assume it null, so i'll retrieve it null (not necessary btw)
  
  //DELETE -->delete all the occureces in the EggTable
  @Query('DELETE FROM EggTable')
  Future<void> deleteAllEgg();


}