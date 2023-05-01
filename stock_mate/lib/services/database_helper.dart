import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_mate/models/inventory_item.dart';

class DatabaseHelper {
  static const _databaseName = 'StockMate.db';
  static const _databaseVersion = 1;

  static const _tableName = 'inventory';

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create the database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        expiry_date TEXT,
        price INTEGER,
        inventory_type TEXT,
        memo TEXT
      )
      ''');
  }

  // CRUD operations

  // Insert an item into the database
  Future<int> insert(InventoryItem item) async {
    Database db = await instance.database;
    return await db.insert(_tableName, item.toMap());
  }

  // Fetch all items from the database
  Future<List<InventoryItem?>> fetchAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((item) => InventoryItem.fromMap(item)).toList();
  }

  // Update an item in the database
  Future<int> update(InventoryItem item) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Delete an item from the database
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
