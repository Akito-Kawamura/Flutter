import 'package:flutter/material.dart';
import 'package:stock_mate/inventory_item.dart';
import 'package:stock_mate/inventory_registration_page.dart';
import 'package:stock_mate/database_helper.dart';

class InventoryStatusPage extends StatefulWidget {
  @override
  _InventoryStatusPageState createState() => _InventoryStatusPageState();
}

class _InventoryStatusPageState extends State<InventoryStatusPage> {
  late DatabaseHelper dbHelper;
  late Future<List<InventoryItem?>> _inventoryItems;
  List<InventoryItem?> _items = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    _fetchInventoryItems();
  }

  Future<List<InventoryItem?>> _fetchInventoryItems() async {
    final items = await dbHelper.fetchAll();
    setState(() {
      _items = items;
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家の消費財在庫管理'),
      ),
      body: FutureBuilder<List<InventoryItem?>>(
        future: _inventoryItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                InventoryItem? item = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(item?.name ?? ''),
                    subtitle: Text(item?.store ?? ''),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('在庫データが存在しません'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InventoryRegistrationPage(),
                        ),
                      );
                    },
                    child: const Text('在庫データを登録する'),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventoryRegistrationPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
