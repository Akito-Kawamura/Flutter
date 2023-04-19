// 既存のインポートに加えて、以下を追加
import 'package:stock_mate/inventory_item.dart';

class DatabaseHelper {
  // 既存のコード...

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
}
