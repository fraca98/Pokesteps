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
            'CREATE TABLE IF NOT EXISTS `Egg` (`idtable` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER NOT NULL, `name` TEXT NOT NULL, `hatchcounter` INTEGER NOT NULL, `openegg` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EggDao get eggdao {
    return _eggdaoInstance ??= _$EggDao(database, changeListener);
  }
}

class _$EggDao extends EggDao {
  _$EggDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _eggInsertionAdapter = InsertionAdapter(
            database,
            'Egg',
            (Egg item) => <String, Object?>{
                  'idtable': item.idtable,
                  'id': item.id,
                  'name': item.name,
                  'hatchcounter': item.hatchcounter,
                  'openegg': item.openegg ? 1 : 0
                }),
        _eggUpdateAdapter = UpdateAdapter(
            database,
            'Egg',
            ['idtable'],
            (Egg item) => <String, Object?>{
                  'idtable': item.idtable,
                  'id': item.id,
                  'name': item.name,
                  'hatchcounter': item.hatchcounter,
                  'openegg': item.openegg ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Egg> _eggInsertionAdapter;

  final UpdateAdapter<Egg> _eggUpdateAdapter;

  @override
  Future<List<Egg>> findAllEggs() async {
    return _queryAdapter.queryList('SELECT * FROM Egg',
        mapper: (Map<String, Object?> row) => Egg(
            idtable: row['idtable'] as int?,
            id: row['id'] as int,
            name: row['name'] as String,
            hatchcounter: row['hatchcounter'] as int,
            openegg: (row['openegg'] as int) != 0));
  }

  @override
  Future<Egg?> lastEgg() async {
    return _queryAdapter.query(
        'SELECT * FROM Egg ORDER BY idtable DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Egg(
            idtable: row['idtable'] as int?,
            id: row['id'] as int,
            name: row['name'] as String,
            hatchcounter: row['hatchcounter'] as int,
            openegg: (row['openegg'] as int) != 0));
  }

  @override
  Future<void> insertEgg(Egg egg) async {
    await _eggInsertionAdapter.insert(egg, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatelastopenegg(Egg updatelastopenegg) async {
    await _eggUpdateAdapter.update(
        updatelastopenegg, OnConflictStrategy.replace);
  }
}
