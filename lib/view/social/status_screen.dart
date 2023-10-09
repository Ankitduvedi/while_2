import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/view/social/full_screen_status.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});
  @override
  StatusScreenState createState() => StatusScreenState();
}

class StatusScreenState extends State<StatusScreen> {
  final TextEditingController _statusTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _currentUser;
  List<String> friends = [];
  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('statuses').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final statusDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: statusDocs.length,
            itemBuilder: (context, index) {
              final status = statusDocs[index].data() as Map<String, dynamic>;

              return Hero(
                tag: 'status_${status['statusId']}',
                child: ListTile(
                  onTap: () {
                    // Navigate to the full status view screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullStatusScreen(status: status),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(status[
                        'profileImg']), // Replace with the user's profile image URL
                  ),
                  title: Text(
                    status['userName'], // Replace with the user's name
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(status['statusText']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showStatusInputDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showStatusInputDialog(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Use ImageSource.camera for the camera

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Display the selected image in a dialog or store it for posting with status
      _showImagePreviewDialog(imageFile);
    }
  }

  void _showImagePreviewDialog(File imageFile) {
    showDialog<void>(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image Preview'),
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(imageFile),
              TextField(
                controller: _statusTextController,
                decoration: const InputDecoration(
                  hintText: 'Enter your status',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Post'),
              onPressed: () {
                _postStatus(imageFile);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _postStatus(File imageFile) async {
    final statusText = _statusTextController.text;
    final userId = APIs.me.id; // Replace with the actual user's ID

    // Upload the image to Firebase Storage
    final storageReference =
        FirebaseStorage.instance.ref().child('$userId/${DateTime.now()}.png');
    await storageReference.putFile(imageFile);

    // Get the image URL from Firebase Storage
    final imageUrl = await storageReference.getDownloadURL();

    FirebaseFirestore.instance.collection('statuses').add({
      'userId': userId,
      'userName': APIs.me.name,
      'profileImg': APIs.me.image,
      'statusText': statusText,
      'imageUrl': imageUrl, // Add the URL of the uploaded image
      'timestamp': FieldValue.serverTimestamp(),
      // Add other necessary fields like user name and profile image URL
    });

    _statusTextController.clear();
  }

  @override
  void dispose() {
    _statusTextController.dispose();
    super.dispose();
  }
}
