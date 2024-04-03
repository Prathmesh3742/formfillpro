import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late CollectionReference updatesCollection;
  late String userId;

  @override
  void initState() {
    super.initState();
    updatesCollection = FirebaseFirestore.instance.collection('updates');
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshScreen,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: updatesCollection.where('userId', isEqualTo: userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            List<UpdateInfo> updates = documents
                .map((doc) => UpdateInfo(
                      name: doc['name'],
                      updateName: doc['updateName'], // Add this line
                      documentsRequired: List<String>.from(doc['documentsRequired']),
                      imageUrls: List<String>.from(doc['imageUrls']),
                    ))
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (updates.isNotEmpty)
                    ...updates.map((update) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${update.name}: ${update.updateName}', // Modify this line
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Documents Uploaded:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          ...update.documentsRequired.map((document) => Text(document)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Download images for this update
                              _downloadImages(update);
                            },
                            child: const Text('Download Images'),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList()
                  else
                    const Text('No updates applied yet.'),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _refreshScreen() async {
    setState(() {}); // Trigger a rebuild
  }

  Future<void> _downloadImages(UpdateInfo update) async {
    // Download images logic
  }
}

class UpdateInfo {
  final String name;
  final String updateName; // Add this line
  final List<String> documentsRequired;
  final List<String> imageUrls;

  UpdateInfo({
    required this.name,
    required this.updateName, // Add this line
    required this.documentsRequired,
    required this.imageUrls,
  });
}
