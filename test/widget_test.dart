import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_modul2/main.dart';
import 'package:flutter_modul2/login_page.dart';
import 'package:flutter_modul2/home_page.dart';
import 'package:flutter_modul2/about_page.dart';
import 'package:flutter_modul2/sidemenu.dart';
import 'package:flutter_modul2/hello_world.dart';
import 'package:flutter_modul2/column_widget.dart';
import 'package:flutter_modul2/row_widget.dart';
import 'package:flutter_modul2/ui/produk_form.dart';
import 'package:flutter_modul2/ui/produk_detail.dart';
import 'package:flutter_modul2/ui/produk_page.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('MyApp and LoginPage smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Masukkan Username'), findsOneWidget);
    expect(find.text('Masukkan Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('LoginPage success login flow and navigation to HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    await tester.enterText(textFields.at(0), 'admin');
    await tester.enterText(textFields.at(1), 'admin');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Anda Berhasil Login'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman User admin'), findsOneWidget);
  });

  testWidgets('LoginPage failure login flow shows alert', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    await tester.enterText(textFields.at(0), 'user_salah');
    await tester.enterText(textFields.at(1), 'pass_salah');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username dan Password Salah'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.text('Masukkan Username'), findsOneWidget);
  });

  testWidgets('LoginPage empty credentials login failure flow', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username dan Password Salah'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.text('Masukkan Username'), findsOneWidget);
  });

  testWidgets('HomePage displays null when no username in SharedPreferences', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman User null'), findsOneWidget);
  });

  testWidgets('HomePage drawer and navigation to AboutPage test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'username': 'admin'});
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman User admin'), findsOneWidget);

    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sidemenu'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    await tester.tap(find.text('About'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('About Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman About'), findsOneWidget);
  });

  testWidgets('AboutPage drawer and navigation to HomePage test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'username': 'admin'});
    await tester.pumpWidget(const MaterialApp(home: AboutPage()));
    await tester.pumpAndSettle();

    expect(find.text('About Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman About'), findsOneWidget);

    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Sidemenu'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Ini adalah halaman User admin'), findsOneWidget);
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
