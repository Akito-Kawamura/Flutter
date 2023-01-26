import 'package:flutter/material.dart';

// 配列から行を作成する
_toTableRow(List<String> list) {
  return list
      .map((e) => Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(e)))
      .toList();
}

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('child 1'),
            color: Colors.red,
            height: 100,
            width: 100,
          ),
          Container(
            child: Text('child 2'),
            color: Colors.blue,
            height: 100,
            width: 100,
          ),
          Table(
            border: TableBorder.all(color: Colors.grey),
            children: <TableRow>[
              TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  children: _toTableRow(['title1', 'title2'])),
              TableRow(
                children: _toTableRow(['abc', '123']),
              ),
            ],
          )
        ],
      ),
    );
  }
}