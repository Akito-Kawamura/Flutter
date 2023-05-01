import 'package:flutter/material.dart';
import 'package:stock_mate/pages/inventory_registration_page.dart';
import 'package:stock_mate/pages/inventory_status_page.dart';

class StockMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stock Mate'),
        ),
        drawer: _buildDrawer(context),
        body: InventoryStatusPage(),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventory Status'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryStatusPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Register Inventory'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryRegistrationPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
