import 'package:flutter/material.dart';
import 'Navbar.dart';
import 'HomeWidgetList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        body: const HomeWidgetList(),
        drawer: const Navbar(),
      ),
    );
  }
}
