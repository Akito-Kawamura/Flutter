import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('トップページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('在庫切れになりそうな商品:'),
            // 商品一覧を表示するウィジェットをここに追加
            // 購入済みボタンを押すと在庫を更新する処理を実装
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('在庫登録'),
              onTap: () {
                Navigator.pushNamed(context, '/inventory_registration');
              },
            ),
            ListTile(
              title: Text('在庫状況確認'),
              onTap: () {
                Navigator.pushNamed(context, '/inventory_status');
              },
            ),
          ],
        ),
      ),
    );
  }
}
