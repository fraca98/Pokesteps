import 'package:floor/floor.dart';
import 'package:pokesteps/database/entities_db/PokemonTable.dart';

//This class defines a dao
@dao
abstract class PokemonDao {

  //SELECT -> this allows to obtain all the entries of the pokemon table
  @Query('SELECT * FROM PokemonTable')
  Future<List<PokemonTable>> findAllPokemon();

  //INSERT --> this allows to insert a pokemon in the table
  @Insert(onConflict: OnConflictStrategy.ignore) //if already exist, skip
  Future<void> insertPokemon(PokemonTable pokemon);

  //SELECT -> retrieve Pokemon info given his id
  @Query('SELECT * FROM PokemonTable WHERE id = :id')
  Future<PokemonTable?> pokemonInfoId(int id);

}