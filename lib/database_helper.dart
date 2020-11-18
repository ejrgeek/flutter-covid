import 'package:app_covid/estado_covid_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'estado_covid.dart';

class DatabaseHelper implements EstodoCovidDAO {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();

  static const _db_name = 'covid.db';
  static const _tb_name = 'tb_covid';

  Database _db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  DatabaseHelper._internal();

  get db async {
    return _db != null ? _db : await initializateDB();
  }

  _onCreate(Database db, int version) async {
    String sql = """
    CREATE TABLE $_tb_name (
      uid INTEGER PRIMARY KEY UNIQUE,
      uf VARCHAR(2),
      state TEXT,
      cases INTERGER,
      deaths INTERGER,
      suspects INTERGER,
      refuses INTERGER,
      datetime TEXT
    )
    """;
    await db.execute(sql);
  }

  initializateDB() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, _db_name);

    var database = await openDatabase(
      pathDB,
      version: 1,
      onCreate: _onCreate,
    );

    return database;
  }

  @override
  getAll() async {
    var database = await db;

    String sql = "SELECT * FROM $_tb_name ORDER BY uf ASC";
    List list = await database.rawQuery(sql);
    return list;
  }

  @override
  insertAll(List<EstadoCovid> estados) async {
    Database database = await db;
    estados.forEach(
      (estado) async {
        await database.insert(_tb_name, estado.toJson());
      },
    );
    return true;
  }

  @override
  orderByCases() async {
    var database = await db;

    String sql = "SELECT * FROM $_tb_name ORDER BY cases DESC";
    List list = await database.rawQuery(sql);
    return list;
  }

  @override
  orderByDeath() async {
    var database = await db;

    String sql = "SELECT * FROM $_tb_name ORDER BY deaths DESC";
    List list = await database.rawQuery(sql);
    return list;
  }

  @override
  updateDB(List<EstadoCovid> estados) async {
    Database database = await db;
    estados.forEach(
      (estado) async {
        await database.update(_tb_name, estado.toJson(),
            where: 'uid = ?', whereArgs: [estado.uid]);
      },
    );

    return true;
  }
}
