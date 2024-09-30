import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Scanpage extends StatefulWidget {
  const Scanpage({super.key});

  @override
  State<Scanpage> createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Scan Your Prescription Here:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
               ElevatedButton(
                onPressed: ()=>_Getimage(context),child: const Text('Scan Document'),
              ),
              const SizedBox(height: 20),
              const Text(
                "Scanned Documents:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
    ),
    );
  }
}

_Getimage(context) async{
      final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera,maxHeight: 1800,maxWidth: 1800);

}