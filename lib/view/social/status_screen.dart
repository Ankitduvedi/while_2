import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/view/social/full_screen_status.dart';
import 'package:intl/intl.dart';

class StatusScreenn extends StatefulWidget {
  const StatusScreenn({super.key});
  @override
  StatusScreenState createState() => StatusScreenState();
}

class StatusScreenState extends State<StatusScreenn> {
  final TextEditingController _statusTextController = TextEditingController();
  List<String> friends = [];
  late String userId;
  late Stream<QuerySnapshot> peopleStream;
  int currentIndex = 0;
  Timer? statusTimer;
  @override
  void initState() {
    super.initState();
    userId = APIs.me.id;
    peopleStream = FirebaseFirestore.instance
        .collection('statuses')
        .orderBy('userId')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    log('////');
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: peopleStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final peopleDocs = snapshot.data!.docs;
          // Fetch the list of people that the current user is following
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('my_users')
                .snapshots(),
            builder: (context, followingSnapshot) {
              if (followingSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (followingSnapshot.hasError) {
                return Center(child: Text('Error: ${followingSnapshot.error}'));
              }

              final followingDocs =
                  followingSnapshot.data!.docs.map((doc) => doc.id).toList();

              // Filter out the people who are already followed by the user
              final filteredPeople = peopleDocs.where((personDoc) {
                final person = personDoc.data() as Map<String, dynamic>;
                final personId = person['userId'];
                return personId == userId || followingDocs.contains(personId);
              }).toList();
              log(filteredPeople.toString());
              return ListView.builder(
                itemCount: filteredPeople.length,
                itemBuilder: (context, index) {
                  List<QueryDocumentSnapshot<Object?>> querySnapshotList =
                      filteredPeople; // Your list of QueryDocumentSnapshots

                  List<Map<String, dynamic>> resultList =
                      querySnapshotList.map((snapshot) {
                    // Extract data from the QueryDocumentSnapshot
                    Map<String, dynamic> data =
                        snapshot.data() as Map<String, dynamic>;
                    return data;
                  }).toList();
                  final person =
                      filteredPeople[index].data() as Map<String, dynamic>;
                  final timestamp = person['timestamp'] as Timestamp;
                  final dateTime = timestamp
                      .toDate(); // Convert Firestore timestamp to DateTime
                  final formattedDate = DateFormat.yMd()
                      .add_Hms()
                      .format(dateTime); // Format the DateTime as a string

                  return Hero(
                    tag: 'status_${person['statusId']}',
                    child: ListTile(
                      onTap: () {
                        // Navigate to the full status view screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullStatusScreen(
                              statuses: resultList,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .03),
                        child: CachedNetworkImage(
                          width: mq.height * .055,
                          height: mq.height * .055,
                          fit: BoxFit.fill,
                          imageUrl: person['profileImg'],
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                      ),
                      title: Text(person['userName']),
                      subtitle: Text(formattedDate),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showStatusInputDialog(context);
        },
        child: const Icon(
          Icons.add,
        ),
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
