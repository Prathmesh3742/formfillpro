import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentUploadForm extends StatefulWidget {
  final List<String> documentsRequired;
  final String documentName;
  final String updateName; // New parameter

  const DocumentUploadForm({Key? key, required this.documentsRequired, required this.documentName, required this.updateName}) : super(key: key);

  @override
  _DocumentUploadFormState createState() => _DocumentUploadFormState();
}

class _DocumentUploadFormState extends State<DocumentUploadForm> {
  final Map<String, File?> _images = {};
  final picker = ImagePicker();
  bool _uploadButtonEnabled = false; // Track the upload button enabled status

  late String _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _updateUploadButtonStatus();
  }

  Future<void> _fetchUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void _updateUploadButtonStatus() {
    bool allImagesSelected = widget.documentsRequired.every((fieldName) => _images[fieldName] != null);
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
        const SnackBar(
          content: Text('Please upload all images before proceeding.'),
        ),
      );
      return;
    }

    try {
      List<String> imageUrls = await uploadImages(); // Upload images and get their URLs
      await applyForUpdate(imageUrls); // Apply for update by creating a document in Firestore
      // Show success message if all images are uploaded and update is applied successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update applied successfully.'),
        ),
      );
    } catch (e) {
      print('Error applying for update: $e');
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];
    for (final fieldName in _images.keys) {
      final image = _images[fieldName];
      if (image != null) {
        String imageUrl = await uploadImageToFirebase(image);
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;
  }

  Future<String> uploadImageToFirebase(File image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(image);

    String downloadURL = await ref.getDownloadURL();

    return downloadURL;
  }

  Future<void> applyForUpdate(List<String> imageUrls) async {
    try {
      await FirebaseFirestore.instance.collection('updates').add({
        'userId': _userId,
        'name': widget.documentName,
        'updateName': widget.updateName, // Add updateName field
        'documentsRequired': widget.documentsRequired,
        'imageUrls': imageUrls,
      });
    } catch (e) {
      print('Error applying for update: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final fieldName in widget.documentsRequired) ...[
                  Text(
                    fieldName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  child: const Text('Upload Images and Apply for Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
