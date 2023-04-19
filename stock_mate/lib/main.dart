import 'package:flutter/material.dart';
import 'home_page.dart';
import 'inventory_registration_page.dart';
import 'inventory_status_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '家の消費財在庫管理',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/inventory_registration': (context) => InventoryRegistrationPage(),
        // '/inventory_status': (context) => InventoryStatusPage(),
      },
    );
  }
}
