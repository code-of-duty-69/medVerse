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
          title: Image.asset(
            'images/logo.jpg',
            height: 96,
            width: 150,
          ),
          toolbarHeight: 110.0,
          backgroundColor: const Color.fromARGB(255, 35, 170, 233),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: const HomeWidgetList(),
        drawer: const Navbar(),
      ),
    );
  }
}
