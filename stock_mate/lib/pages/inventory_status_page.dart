import 'package:flutter/material.dart';
import 'package:stock_mate/models/inventory_item.dart';
import 'package:stock_mate/services/database_helper.dart';
import 'package:stock_mate/services/utils.dart';

class InventoryStatusPage extends StatefulWidget {
  @override
  _InventoryStatusPageState createState() => _InventoryStatusPageState();
}

class _InventoryStatusPageState extends State<InventoryStatusPage> {
  late Future<List<InventoryItem>> _inventoryItems;

  @override
  void initState() {
    super.initState();
    _inventoryItems = _fetchInventoryItems();
  }

  Future<List<InventoryItem>> _fetchInventoryItems() async {
    final dbHelper = DatabaseHelper.instance;
    final items = await dbHelper.queryAllInventoryItems();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InventoryItem>>(
      future: _inventoryItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          if (items.isEmpty) {
            return _buildEmptyListPlaceholder();
          } else {
            return _buildInventoryItemsGrid(items);
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildEmptyListPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('在庫データが存在しません'),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/inventory_registration');
            },
            child: Text('在庫データを登録する'),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItemsGrid(List<InventoryItem> items) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return _buildInventoryItemCard(item);
      },
    );
  }

  Widget _buildInventoryItemCard(InventoryItem item) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${item.name}'),
          Text('Next Purchase: ${Utils.formatDate(item.nextPurchaseDate)}'),
          Text('Purchase Place: ${item.purchasePlace ?? 'N/A'}'),
          Text('Price: ${item.price ?? 'N/A'}'),
        ],
      ),
    );
  }
}
