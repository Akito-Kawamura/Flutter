import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Database instance
  static Database _db;

  // Factory constructor
  factory DatabaseHelper() => _instance;

  // Internal constructor
  DatabaseHelper._internal();

  // Initialize database
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await _initDb();
    return _db;
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
    await db.execute('CREATE TABLE inventory (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER)');
  }

  // CRUD operations and other methods
}
