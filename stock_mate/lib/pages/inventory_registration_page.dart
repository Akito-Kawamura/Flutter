import 'package:flutter/material.dart';
import 'package:stock_mate/models/inventory_item.dart';
import 'package:stock_mate/services/database_helper.dart';
import 'package:stock_mate/services/utils.dart';

class InventoryRegistrationPage extends StatefulWidget {
  @override
  _InventoryRegistrationPageState createState() =>
      _InventoryRegistrationPageState();
}

class _InventoryRegistrationPageState extends State<InventoryRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _purchasePlaceController = TextEditingController();
  final TextEditingController _timingController = TextEditingController();
  final TextEditingController _onlineStoreUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫登録画面'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildNameInput(),
                _buildPurchasePlaceInput(),
                _buildTimingInput(),
                _buildOnlineStoreUrlInput(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: '商品名',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '商品名は必須です';
        }
        return null;
      },
    );
  }

  Widget _buildPurchasePlaceInput() {
    return TextFormField(
      controller: _purchasePlaceController,
      decoration: InputDecoration(
        labelText: '購入先',
      ),
    );
  }

  Widget _buildTimingInput() {
    return TextFormField(
      controller: _timingController,
      decoration: InputDecoration(
        labelText: 'なくなるタイミング（日数）',
      ),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'タイミングは必須です';
        }
        return null;
      },
    );
  }

  Widget _buildOnlineStoreUrlInput() {
    return TextFormField(
      controller: _onlineStoreUrlController,
      decoration: InputDecoration(
        labelText: '通販用URL',
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // フォームが有効な場合
          final inventoryItem = InventoryItem(
            name: _nameController.text,
            purchasePlace: _purchasePlaceController.text,
            timing: int.parse(_timingController.text),
            onlineStoreUrl: _onlineStoreUrlController.text,
            updateDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          );
          inventoryItem.nextPurchaseDate = Utils.calculateNextPurchaseDate(
              inventoryItem.timing, inventoryItem.updateDate);

          final dbHelper = DatabaseHelper.instance;
          await dbHelper.insertInventoryItem(inventoryItem);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('登録できました'),
                actions: [
                  TextButton(
                    onPressed:
                                        () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text('登録'),
    );
  }
}

