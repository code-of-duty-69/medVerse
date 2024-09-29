import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final List<XFile> _scannedDocuments = []; // To store scanned documents

  // Method to ask for camera permission
  Future<void> _askCameraPermission() async {
    if (await Permission.camera.isGranted) {
      _scanDocument();
    } else {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        _scanDocument();
      } else {
        _showPermissionDeniedDialog();
      }
    }
  }

  // Method to scan the document
  Future<void> _scanDocument() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _scannedDocuments.add(image);
      });
    }
  }

  // Show a dialog if permission is denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Camera Permission Denied"),
        content: const Text(
            "You need to grant camera permission to scan documents."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDVERSE'),
        backgroundColor: const Color.fromARGB(255, 43, 147, 231),
      ),
      body: SingleChildScrollView(
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
                onPressed: _askCameraPermission,
                child: const Text('Scan Document'),
              ),
              const SizedBox(height: 20),
              const Text(
                "Scanned Documents:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildScannedDocumentsList(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the scanned documents
  Widget _buildScannedDocumentsList() {
    if (_scannedDocuments.isEmpty) {
      return const Text('No documents scanned yet.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _scannedDocuments.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.file(
            File(_scannedDocuments[index].path),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text('Document ${index + 1}'),
        );
      },
    );
  }
}
