import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const KbdApp());
}

class KbdApp extends StatelessWidget {
  const KbdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kbd Convert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Kbd Convert'),
    );
  }
}
