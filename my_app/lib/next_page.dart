import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Column(
          children: [
            Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          ],
        ),
    );
  }
}