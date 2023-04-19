import 'package:flutter/material.dart';
import 'package:stock_mate/database_helper.dart';
import 'package:stock_mate/inventory_item.dart';
import 'package:stock_mate/inventory_registration_page.dart';

class InventoryStatusPage extends StatefulWidget {
  @override
  _InventoryStatusPageState createState() => _InventoryStatusPageState();
}

class _InventoryStatusPageState extends State<InventoryStatusPage> {
  // データベースヘルパーインスタンス
  final dbHelper = DatabaseHelper();

  // 消費財情報をデータベースから取得
  Future<List<InventoryItem>> fetchInventoryItems() async {
    return await dbHelper.fetchAllInventoryItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫状況'),
      ),
      body: FutureBuilder<List<InventoryItem>>(
        future: fetchInventoryItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2 / 1,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  InventoryItem item = snapshot.data[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('商品名: ${item.name}'),
                        Text('購入先: ${item.store}'),
                        Text('次の購入時期: ${item.timing}'),
                        Text('価格: ${item.price}'),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('在庫データが存在しません。'),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InventoryRegistrationPage()),
                        );
                      },
                      child: Text('在庫データを登録する'),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました。'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
