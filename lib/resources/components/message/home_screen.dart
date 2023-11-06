import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:while_app/resources/components/communities/chat_user_card.dart';
import '../../../main.dart';
import 'apis.dart';
import 'helper/dialogs.dart';
import 'models/chat_user.dart';

class HomeScreenFinal extends StatefulWidget {
  const HomeScreenFinal({
    super.key,
    required this.isSearching,
    required this.value,
  });

  final bool isSearching;
  final String value;

  @override
  State<HomeScreenFinal> createState() => _HomeScreenFinalState();
}

class _HomeScreenFinalState extends State<HomeScreenFinal> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = widget.isSearching;

    if (widget.value != '') {
      log(widget.value);
      _searchList.clear();

      for (var i in list) {
        if (i.name.toLowerCase().contains(widget.value.toLowerCase()) ||
            i.email.toLowerCase().contains(widget.value.toLowerCase())) {
          _searchList.add(i);
        }
      }
    }

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            _addChatUserDialog();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(APIs.me.id)
            .collection('my_users')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available.'));
          }

          List<String> userIds = snapshot.data!.docs.map((e) => e.id).toList();
          print('\nuserids $userIds');
          return ListView.builder(
            itemCount: isSearching ? _searchList.length : userIds.length,
            padding: EdgeInsets.only(top: mq.height * .01),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userIds[index])
                    .snapshots(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  if (!userSnapshot.hasData) {
                    return const Center(child: Text('No user data available.'));
                  }

                  // Access the data for the document
                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  final chatUser = ChatUser.fromJson(userData);

                  return ChatUserCard(
                    user: isSearching ? _searchList[index] : chatUser,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _addChatUserDialog() {
    String email = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.blue,
              size: 28,
            ),
            Text('  Add User'),
          ],
        ),
        content: TextFormField(
          maxLines: null,
          onChanged: (value) => email = value,
          decoration: InputDecoration(
            hintText: 'Email Id',
            prefixIcon: const Icon(Icons.email, color: Colors.blue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel',
                style: TextStyle(color: Colors.blue, fontSize: 16)),
          ),
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              if (email.isNotEmpty) {
                await APIs.addChatUser(email).then((value) {
                  if (!value) {
                    Dialogs.showSnackbar(context, 'User does not exist!');
                  }
                });
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
