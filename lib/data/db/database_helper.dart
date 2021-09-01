import 'package:restaurant_app/data/response/restaurant_result.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavoriteRestaurants = 'fav_restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_app.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavoriteRestaurants (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DOUBLE
           )   
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database!;
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tblFavoriteRestaurants);
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tblFavoriteRestaurants, restaurant.toJson());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavoriteRestaurants,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblFavoriteRestaurants,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return Restaurant.fromJson(results.first);
    }

    return null;
  }
}
