import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DocumentUploadForm extends StatefulWidget {
  final List<String> fieldNames;
  final String headerTitle;

  const DocumentUploadForm({Key? key, required this.fieldNames, required this.headerTitle}) : super(key: key);

  @override
  _DocumentUploadFormState createState() => _DocumentUploadFormState();
}

class _DocumentUploadFormState extends State<DocumentUploadForm> {
  final Map<String, File?> _images = {};
  final picker = ImagePicker();

  Future<void> getImage(String fieldName) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images[fieldName] = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImagesToFirebase() async {
    try {
      for (final fieldName in _images.keys) {
        final image = _images[fieldName];
        if (image != null) {
          await uploadImageToFirebase(image);
        }
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(image);

    String downloadURL = await ref.getDownloadURL();

    // Store the download URL in Firestore or perform any other actions as needed
    print('Image uploaded. Download URL: $downloadURL');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final fieldName in widget.fieldNames) ...[
              Text(
                fieldName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => getImage(fieldName),
                child: const Text('Add Image'),
              ),
              if (_images[fieldName] != null)
                Image.file(
                  _images[fieldName]!,
                  width: 200,
                  height: 200,
                ),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: uploadImagesToFirebase,
              child: const Text('Upload Images to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
