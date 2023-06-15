import 'package:currency_converter/screens/ConverterPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ConverterPage(),
    );
  }
}
