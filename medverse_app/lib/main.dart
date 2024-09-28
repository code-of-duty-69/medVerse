import 'package:flutter/material.dart';
import 'Navbar.dart';
import 'HomeWidgetList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedVerse',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MEDVERSE'),
          backgroundColor: const Color.fromARGB(255, 43, 147, 231),
        ),
        body: HomeWidgetList(),
        drawer: Navbar(),
      ),
    );
  }
}
