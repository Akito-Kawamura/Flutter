import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_mate/inventory_item.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Database instance
  static Database? _db;

  // Factory constructor
  factory DatabaseHelper() => _instance;

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // プライベートコンストラクタ
  DatabaseHelper._privateConstructor();

  // Internal constructor
  DatabaseHelper._internal();

  // テーブル名を定義
  final String _tableName = 'inventory';

  // Initialize database
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  // Initialize database
  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'inventory.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // Create database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE inventory (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        store TEXT, 
        timing INTEGER, 
        price REAL, 
        url TEXT)
      ''');
  }

  // Create new inventory item
  Future<int> insertInventoryItem(InventoryItem item) async {
    var dbClient = await db;
    var result = await dbClient.insert('inventory', item.toMap());
    return result;
  }

  // Update an existing inventory item
  Future<int> updateInventoryItem(InventoryItem item) async {
    var dbClient = await db;
    var result = await dbClient.update('inventory', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
    return result;
  }

  // Delete an inventory item
  Future<int> deleteInventoryItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.delete('inventory', where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // Fetch all inventory items
  Future<List<InventoryItem>> fetchAllInventoryItems() async {
    var dbClient = await db;
    var result = await dbClient.query('inventory');
    return result.map((item) => InventoryItem.fromMap(item)).toList();
  }

  // InventoryItemをデータベースに挿入するメソッド
  Future<int> insert(InventoryItem item) async {
    Database db = await instance.database;
    return await db.insert(_tableName, item.toMap());
  }
}
