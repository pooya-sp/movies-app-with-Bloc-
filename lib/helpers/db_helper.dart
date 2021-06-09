import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'movies.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE movies_table(posterImage TEXT ,title TEXT,overview TEXT,id TEXT PRIMARY KEY,isFavorite INTEGER)');
      await db.execute(
          'CREATE TABLE favorite_movies(posterImage TEXT ,title TEXT,overview TEXT,id TEXT PRIMARY KEY,isFavorite INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> updateData(
      String table, Map<String, dynamic> data, String id) async {
    final db = await DBHelper.database();
    return db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteData(String table) async {
    final db = await DBHelper.database();
    return db.delete(table);
  }

  static Future<int> deleteRow(String table, String id) async {
    final db = await DBHelper.database();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
