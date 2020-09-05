import 'package:demo/test/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test contacts', (WidgetTester tester) async {
    ///注入widget
    await tester.pumpWidget(Contacts(['a', 'b', 'c']));
    ///在Contacts中查找widget
    final aT = find.text('a');
    final bT = find.text('b');
    final cT = find.text('c');
    final icons = find.byIcon(Icons.person);

    ///断言
    expect(aT, findsOneWidget);
    expect(bT, findsOneWidget);
    expect(cT, findsOneWidget);
    expect(icons, findsNWidgets(3));
  });

}