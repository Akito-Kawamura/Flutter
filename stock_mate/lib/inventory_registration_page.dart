import 'package:flutter/material.dart';
import 'package:stock_mate/database_helper.dart';
import 'package:stock_mate/inventory_item.dart';


class InventoryRegistrationPage extends StatefulWidget {
  const InventoryRegistrationPage({Key? key}) : super(key: key);

  @override
  _InventoryRegistrationPageState createState() => _InventoryRegistrationPageState();
}

class _InventoryRegistrationPageState extends State<InventoryRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _store = '';
  String _timing = '';
  double _price = 0.0;
  String _url = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "商品名 *",
                  hintText: "商品名を入力してください",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '商品名は必須です';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "購入場所",
                  hintText: "購入場所を入力してください",
                ),
                onSaved: (value) => _store = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "なくなるタイミング",
                  hintText: "例: 1d, 2w, 3m",
                ),
                onSaved: (value) => _timing = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "価格",
                  hintText: "価格を入力してください",
                  prefixText: "¥",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onSaved: (value) => _price = double.tryParse(value ?? '0.0') ?? 0.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "URL",
                  hintText: "URLを入力してください",
                ),
                onSaved: (value) => _url = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('登録'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      InventoryItem newItem = InventoryItem(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _name,
        store: _store,
        timing: _timing,
        price: _price.toInt(),
        url: _url,
      );
      await DatabaseHelper.instance.insert(newItem);
      Navigator.pop(context);
    }
  }
}
