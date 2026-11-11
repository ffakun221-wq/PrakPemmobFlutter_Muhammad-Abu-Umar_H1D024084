import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_modul2/main.dart';
import 'package:flutter_modul2/hello_world.dart';
import 'package:flutter_modul2/column_widget.dart';
import 'package:flutter_modul2/row_widget.dart';
import 'package:flutter_modul2/ui/produk_form.dart';
import 'package:flutter_modul2/ui/produk_detail.dart';
import 'package:flutter_modul2/ui/produk_page.dart';

void main() {
  testWidgets('MyApp and ProdukPage smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('List Data Produk'), findsOneWidget);
    expect(find.text('Kulkas'), findsOneWidget);
    expect(find.text('Playstation'), findsOneWidget);
    expect(find.text('Radio'), findsOneWidget);
    expect(find.text('30000'), findsNWidgets(3));
  });

  testWidgets('ProdukPage direct widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProdukPage()));

    expect(find.text('List Data Produk'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.byType(ListTile), findsNWidgets(3));
  });

  testWidgets('HelloWorld widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HelloWorld()));

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('ColumnWidget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ColumnWidget()));

    expect(find.text('Widget Column'), findsOneWidget);
    expect(find.text('Kolom 1'), findsOneWidget);
    expect(find.text('Kolom 3'), findsOneWidget);
    expect(find.text('Kolom 2'), findsOneWidget);
    expect(find.text('Kolom 4'), findsOneWidget);
  });

  testWidgets('RowWidget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RowWidget()));

    expect(find.text('Widget Row'), findsOneWidget);
    expect(find.text('Row 1'), findsOneWidget);
    expect(find.text('Row 2'), findsOneWidget);
    expect(find.text('Row 3'), findsOneWidget);
    expect(find.text('Row 4'), findsOneWidget);
  });

  testWidgets('ProdukForm input and navigation to ProdukDetail test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProdukForm()));

    expect(find.text('Form Produk'), findsOneWidget);
    expect(find.text('Kode Produk'), findsOneWidget);
    expect(find.text('Nama Produk'), findsOneWidget);
    expect(find.text('Harga'), findsOneWidget);

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    await tester.enterText(textFields.at(0), 'BRG001');
    await tester.enterText(textFields.at(1), 'Laptop Gaming');
    await tester.enterText(textFields.at(2), '15000000');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Produk'), findsOneWidget);
    expect(find.text('Kode Produk : BRG001'), findsOneWidget);
    expect(find.text('Nama Produk : Laptop Gaming'), findsOneWidget);
    expect(find.text('Harga Produk : 15000000'), findsOneWidget);
  });

  testWidgets('ProdukDetail widget test directly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ProdukDetail(
        kodeProduk: 'A01',
        namaProduk: 'Meja',
        hargaProduk: 250000,
      ),
    ));

    expect(find.text('Detail Produk'), findsOneWidget);
    expect(find.text('Kode Produk : A01'), findsOneWidget);
    expect(find.text('Nama Produk : Meja'), findsOneWidget);
    expect(find.text('Harga Produk : 250000'), findsOneWidget);
  });
}
