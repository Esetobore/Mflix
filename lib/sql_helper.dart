import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabaseHelper{

  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mflix.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void>_createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        posterPath TEXT
      )
    ''');
  }

  static Future<int> insertMovie(String title, String posterPath) async {
    final db = await _openDatabase();
    final data = {
      'title': title,
      'posterPath': posterPath,
    };
    return await db.insert('movies', data);
  }

  static Future<List<Map<String, dynamic>>> getMovies() async {
    final db = await _openDatabase();
    return await db.query('movies');
  }

  static Future<int> deleteMovie(int id) async {
    final db = await _openDatabase();
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }


}