// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_learning2/main.dart';


void main() {
  testWidgets('CRUD App initial load test', (WidgetTester tester) async {
    // 1. Membangun aplikasi kita.
    await tester.pumpWidget(const App());

    // 2. Memastikan judul di AppBar muncul sesuai materi.
    // Ganti teks jika judul AppBar Anda berbeda.
    expect(find.text('CRUD (Local) + Picker'), findsOneWidget);

    // 3. Memastikan tombol Tambah (+) ada di layar.
    expect(find.byIcon(Icons.add), findsOneWidget);

    // 4. Memastikan indikator loading muncul saat awal karena proses asinkron.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}