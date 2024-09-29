import 'package:flutter/material.dart';

class Scanpage extends StatelessWidget {
  const Scanpage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MEDVERSE'),
          backgroundColor: const Color.fromARGB(255, 43, 147, 231),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Scan Your Prescription Here:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [],
                )
              ],
            ),
          ),
        ),
      );
}
