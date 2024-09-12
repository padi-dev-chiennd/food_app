import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'images.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT)",
        );
      },
    );
  }

  Future<void> insertImage(String path) async {
    final db = await database;
    await db.insert(
      'images',
      {'path': path},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');
    return List.generate(maps.length, (i) {
      return maps[i]['path'];
    });
  }

  Future<void> deleteImage(int id) async {
    final db = await database;
    await db.delete(
      'images',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
