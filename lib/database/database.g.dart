// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EggDao? _eggdaoInstance;

  PokemonDao? _pokemonDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EggTable` (`autoid` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER NOT NULL, `openegg` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PokemonTable` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `hatchcounter` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EggDao get eggdao {
    return _eggdaoInstance ??= _$EggDao(database, changeListener);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$EggDao extends EggDao {
  _$EggDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _eggTableInsertionAdapter = InsertionAdapter(
            database,
            'EggTable',
            (EggTable item) => <String, Object?>{
                  'autoid': item.autoid,
                  'id': item.id,
                  'openegg': item.openegg ? 1 : 0
                }),
        _eggTableUpdateAdapter = UpdateAdapter(
            database,
            'EggTable',
            ['autoid'],
            (EggTable item) => <String, Object?>{
                  'autoid': item.autoid,
                  'id': item.id,
                  'openegg': item.openegg ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EggTable> _eggTableInsertionAdapter;

  final UpdateAdapter<EggTable> _eggTableUpdateAdapter;

  @override
  Future<List<EggTable>> findAllEggs() async {
    return _queryAdapter.queryList('SELECT * FROM EggTable',
        mapper: (Map<String, Object?> row) => EggTable(
            autoid: row['autoid'] as int?,
            id: row['id'] as int,
            openegg: (row['openegg'] as int) != 0));
  }

  @override
  Future<EggTable?> lastEgg() async {
    return _queryAdapter.query(
        'SELECT * FROM EggTable ORDER BY autoid DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => EggTable(
            autoid: row['autoid'] as int?,
            id: row['id'] as int,
            openegg: (row['openegg'] as int) != 0));
  }

  @override
  Future<List<EggTable>> getnumberinpokedex() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT id,openegg FROM EggTable WHERE openegg=1 ORDER BY id ASC',
        mapper: (Map<String, Object?> row) => EggTable(
            autoid: row['autoid'] as int?,
            id: row['id'] as int,
            openegg: (row['openegg'] as int) != 0));
  }

  @override
  Future<void> deleteAllEgg() async {
    await _queryAdapter.queryNoReturn('DELETE FROM EggTable');
  }

  @override
  Future<void> insertEgg(EggTable egg) async {
    await _eggTableInsertionAdapter.insert(egg, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatelastopenegg(EggTable updatelastopenegg) async {
    await _eggTableUpdateAdapter.update(
        updatelastopenegg, OnConflictStrategy.replace);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _pokemonTableInsertionAdapter = InsertionAdapter(
            database,
            'PokemonTable',
            (PokemonTable item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'hatchcounter': item.hatchcounter
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonTable> _pokemonTableInsertionAdapter;

  @override
  Future<List<PokemonTable>> findAllPokemon() async {
    return _queryAdapter.queryList('SELECT * FROM PokemonTable',
        mapper: (Map<String, Object?> row) => PokemonTable(
            id: row['id'] as int,
            name: row['name'] as String,
            hatchcounter: row['hatchcounter'] as int));
  }

  @override
  Future<PokemonTable?> pokemonInfoId(int id) async {
    return _queryAdapter.query('SELECT * FROM PokemonTable WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PokemonTable(
            id: row['id'] as int,
            name: row['name'] as String,
            hatchcounter: row['hatchcounter'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertPokemon(PokemonTable pokemon) async {
    await _pokemonTableInsertionAdapter.insert(
        pokemon, OnConflictStrategy.ignore);
  }
}
