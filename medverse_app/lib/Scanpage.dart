import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final List<File> _scannedDocuments = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _showScanOptionsDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scan Document'),
          content: const Text('Choose an option to scan your document:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _scanDocument();
              },
              child: const Text('Scan Document'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Choose from Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _scanDocument() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      try {
        final String imagePath = path.join(
          (await getApplicationDocumentsDirectory()).path,
          "${DateTime.now().millisecondsSinceEpoch}.jpg",
        );
        bool success = await EdgeDetection.detectEdge(
          imagePath,
          canUseGallery: false,
          androidScanTitle: 'Scanning',
          androidCropTitle: 'Crop',
          androidCropBlackWhiteTitle: 'Black White',
          androidCropReset: 'Reset',
        );
        if (success) {
          setState(() {
            _scannedDocuments.add(File(imagePath));
          });
        }
      } catch (e) {
        print('Error scanning document: $e');
      }
    } else {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _scannedDocuments.add(File(image.path));
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Scan Your Prescription Here:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showScanOptionsDialog,
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
    );
  }

  Widget _buildScannedDocumentsList() {
    if (_scannedDocuments.isEmpty) {
      return const Text('No documents scanned yet.');
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _scannedDocuments.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.file(
              _scannedDocuments[index],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text('Document ${index + 1}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _scannedDocuments.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }
}
