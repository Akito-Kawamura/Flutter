import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_mate/models/inventory_item.dart'; // InventoryItemをインポート

class DatabaseHelper {
  static final _databaseName = "inventory.db";
  static final _databaseVersion = 1;

  static final table = 'inventoryItems';

  // シングルトンクラスにする
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // データベースへの参照を保持する
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // データベースを開き、テーブルを作成する
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            purchasePlace TEXT,
            timing INTEGER NOT NULL,
            onlineStoreUrl TEXT,
            updateDate INTEGER NOT NULL,
            nextPurchaseDate INTEGER NOT NULL,
            price REAL
          )
          ''',
        );
      },
    );
  }

  // 全てのインベントリアイテムを取得するメソッド
  Future<List<InventoryItem>> queryAllInventoryItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return InventoryItem.fromMap(maps[i]);
    });
  }

  // インベントリアイテムをデータベースに挿入するメソッド
  Future<void> insertInventoryItem(InventoryItem inventoryItem) async {
    final db = await database;
    await db.insert(
      table,
      inventoryItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
