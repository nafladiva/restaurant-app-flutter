import 'package:path/path.dart';
import 'package:restail/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  static String _tableName = 'favorites';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               id_restaurant TEXT, 
               name TEXT,
               pictureId TEXT,
               city TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> addFavorite(RestaurantFavorite restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
    print('Data saved');
  }

  Future<List<RestaurantFavorite>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => RestaurantFavorite.fromMap(res)).toList();
  }

  Future<RestaurantFavorite> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id_restaurant = ?',
      whereArgs: [id],
    );

    return results.map((res) => RestaurantFavorite.fromMap(res)).first;
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id_restaurant = ?',
      whereArgs: [id],
    );

    print('Data deleted');
  }

  Future<void> deleteAllData() async {
    final Database db = await database;

    await db.delete(_tableName);
    db.close();

    print('All data deleted');
  }
}
