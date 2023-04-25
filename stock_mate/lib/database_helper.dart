import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_mate/inventory_item.dart';

class DatabaseHelper {
  static final _databaseName = "Inventory.db";
  static final _databaseVersion = 1;
  static final _tableName = "inventory";

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Private constructor
  DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _db;

  // Getter for the database
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await _initDatabase();
    return _db!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        store TEXT,
        timing TEXT,
        price INTEGER,
        url TEXT
      )
    ''');
  }

  // Insert a new inventory item
  Future<int> insert(InventoryItem item) async {
    Database db = await instance.database;
    return await db.insert(_tableName, item.toMap());
  }

  Future<List<InventoryItem>> fetchAll() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(_tableName);

  return List.generate(maps.length, (i) {
    return InventoryItem(
      id: maps[i]['id'],
      name: maps[i]['name'],
      store: maps[i]['store'],
      timing: maps[i]['timing'],
      price: maps[i]['price'],
      url: maps[i]['url'],
    );
  });
}

}
