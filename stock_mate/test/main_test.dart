import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_mate/main.dart';

void main() {
  testWidgets('Main app test', (WidgetTester tester) async {
    // MyAppウィジェットをビルドしてテスト
    await tester.pumpWidget(MyApp());

    // テストが実行されるまで待つ
    await tester.pumpAndSettle();

    // 期待されるタイトルが存在することを確認
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.widgetWithText(AppBar, '家の消費財在庫管理'), findsOneWidget);
  });
}

