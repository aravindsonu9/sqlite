import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite/ModelClass/ModelClass.dart';

class dbhelper {
  dbhelper.DatabaseHelper();

  static const databaseName = 'databasename.db';
  static final dbhelper instance = dbhelper.DatabaseHelper();
  static Database db;

  Future<Database> get database async {
    if (db == null) {
      return await initializeDatabase();
    }
      return db;
    }


  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),

        version: 1, onCreate: (Database db1, int version) async {
      await db1.execute(
          "CREATE TABLE Datatable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, text TEXT, desc TEXT )");
    });
  }

  insertDBmodel(DBmodel dbmodel) async {
    final db = await database;
    var res = await db.insert(DBmodel.TABLENAME, dbmodel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<DBmodel>> retrieveDBmodel() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DBmodel.TABLENAME);

    return List.generate(maps.length, (i) {
      return DBmodel(
        id: maps[i]['id'],
        text: maps[i]['text'],
        desc: maps[i]['desc'],
      );
    });
  }
  Future<void> updateDBmodel(DBmodel dbmodel) async {
    final db = await database;
    await db.update(
    DBmodel.TABLENAME,
      dbmodel.toMap(),
      where: "id = ?",
      whereArgs: [dbmodel.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  Future<void> deleteDBmodel(int id) async {

    final db = await database;

    await db.delete(
      DBmodel.TABLENAME,

      where: "id = ?",

      whereArgs: [id],

    );
  }

}
