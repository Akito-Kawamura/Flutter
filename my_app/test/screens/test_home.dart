import 'package:flutter_test/flutter_test.dart';
import '../../lib/src/screens/home.dart';

void main() {
  HomeScreen();
  setup(() {
    
  })
}

group('dataSource test', () {
    test("dataSource has 6 data, same as initial data count", () {
      expect(articleListForText.dataSource.length, 6);
    });
  });