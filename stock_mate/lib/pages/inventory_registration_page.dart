import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_mate/models/inventory_item.dart';
import 'package:stock_mate/services/database_helper.dart';

class InventoryRegistrationPage extends StatefulWidget {
  final InventoryItem? inventoryItem;

  InventoryRegistrationPage({this.inventoryItem});

  @override
  _InventoryRegistrationPageState createState() =>
      _InventoryRegistrationPageState();
}

class _InventoryRegistrationPageState extends State<InventoryRegistrationPage> {
  late TextEditingController _nameController;
  late TextEditingController _expiryDateController;
  late TextEditingController _quantityController;
  late TextEditingController _consumptionFrequencyController;
  late TextEditingController _priceController;
  final _formKey = GlobalKey<FormState>();
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.inventoryItem?.name ?? '');
    _expiryDateController =
        TextEditingController(text: widget.inventoryItem?.expiryDate ?? '');
    _quantityController = TextEditingController(
        text: widget.inventoryItem?.quantity.toString() ?? '');
    _consumptionFrequencyController = TextEditingController(
        text: widget.inventoryItem?.consumptionFrequency ?? '');
    _priceController = TextEditingController(
        text: widget.inventoryItem?.price.toString() ?? '');
    _dbHelper = DatabaseHelper.instance;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _expiryDateController.dispose();
    _quantityController.dispose();
    _consumptionFrequencyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.inventoryItem == null
            ? '商品の追加'
            : '商品情報の更新'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '商品名'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '商品名を入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: '消費期限'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: '残量'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextFormField(
                controller: _consumptionFrequencyController,
                decoration: InputDecoration(labelText: '消費頻度'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: '価格'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.inventoryItem == null
                    ? '商品を追加'
                    : '商品情報を更新'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Inventory
