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
  bool _uploadButtonEnabled = false; // Track the upload button enabled status

  @override
  void initState() {
    super.initState();
    _updateUploadButtonStatus();
  }

  void _updateUploadButtonStatus() {
    bool allImagesSelected = widget.fieldNames.every((fieldName) => _images[fieldName] != null);
    setState(() {
      _uploadButtonEnabled = allImagesSelected;
    });
  }

  Future<void> getImage(String fieldName) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images[fieldName] = File(pickedFile.path);
        _updateUploadButtonStatus(); // Update upload button status after adding image
      });
    }
  }

  Future<void> removeImage(String fieldName) async {
    setState(() {
      _images[fieldName] = null;
      _updateUploadButtonStatus(); // Update upload button status after removing image
    });
  }

  Future<void> uploadImagesToFirebase() async {
    // Check if all images are uploaded
    if (!_uploadButtonEnabled) {
      // Show error message if any image is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload all images before proceeding.'),
        ),
      );
      return;
    }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                  if (_images[fieldName] != null) ...[
                    Image.file(
                      _images[fieldName]!,
                      width: 200,
                      height: 200,
                    ),
                    ElevatedButton(
                      onPressed: () => removeImage(fieldName),
                      child: const Text('Remove Image'),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
                ElevatedButton(
                  onPressed: uploadImagesToFirebase,
                  child: const Text('Upload Images to Firebase'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
