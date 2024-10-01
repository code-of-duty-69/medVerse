import 'package:flutter/material.dart';
import 'package:medverse_app/AppTheme.dart';
import 'MedicalDetails.dart';
import 'Navbar.dart';

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
      theme: AppTheme.theme,
      home: Scaffold(
        appBar:  AppBar(
        title :Container(
        height: 96,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),  // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
          toolbarHeight: 110.0,
          backgroundColor: const Color.fromARGB(255, 35, 170, 233),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: const MedicalDetails(),
        drawer: const Navbar(),
      ),
    );
  }
}
