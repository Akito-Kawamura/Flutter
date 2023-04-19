import 'package:flutter/material.dart';
import 'package:stock_mate/database_helper.dart';
import 'package:stock_mate/inventory_item.dart';

class InventoryRegistrationPage extends StatefulWidget {
  @override
  _InventoryRegistrationPageState createState() => _InventoryRegistrationPageState();
}

class _InventoryRegistrationPageState extends State<InventoryRegistrationPage> {
  // 入力フィールドのコントローラー
  TextEditingController nameController = TextEditingController();
  TextEditingController storeController = TextEditingController();
  TextEditingController timingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  // データベースヘルパーインスタンス
  final dbHelper = DatabaseHelper();

  // 消費財情報をデータベースに登録
  void registerItem() async {
    InventoryItem newItem = InventoryItem(
      id: null,
      name: nameController.text,
      store: storeController.text,
      timing: int.parse(timingController.text),
      price: double.parse(priceController.text),
      url: urlController.text,
    );
    await dbHelper.insertInventoryItem(newItem);
    // 登録成功メッセージを表示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('登録しました。')));
    // 入力フィールドをクリア
    nameController.clear();
    storeController.clear();
    timingController.clear();
    priceController.clear();
    urlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫登録'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '商品名'),
            ),
            TextField(
              controller: storeController,
              decoration: InputDecoration(labelText: '購入先'),
            ),
            TextField(
              controller: timingController,
              decoration: InputDecoration(labelText: 'なくなるタイミング'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: '価格'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: '通販用URL（オプション）'),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registerItem,
                child: Text('登録'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
