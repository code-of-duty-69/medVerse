import 'package:flutter/material.dart';
import 'Navbar.dart';

class Chatbotpage extends StatelessWidget {
  const Chatbotpage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MEDVERSE'),
          backgroundColor: const Color.fromARGB(255, 43, 147, 231),
        ),
        drawer: const Navbar(),
      );
}
