import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/classroom/add_classroom_widget.dart';
import 'package:while_app/resources/components/classroom/classroom_home_card.dart';
import 'package:while_app/resources/components/message/models/classroom_user.dart';
import '../message/apis.dart';
import '../message/helper/dialogs.dart';

late Size mq;

//home screen -- where all available classrooms are shown
class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({
    super.key,
  });
  @override
  State<ClassroomScreen> createState() => ClassroomScreenState();
}

class ClassroomScreenState extends State<ClassroomScreen> {
  List<Class> _list = [];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner_outlined))
        ],
      ),
      //floating button to add new user

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              _addCommunityDialog();
                            },
                            title: const Text("Join Class"),
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pop();
                              AddClassScreen().addCommunityDialog(context);
                            },
                            title: const Text("Create Class"),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: const Icon(Icons.add_comment_rounded)),
      ),
      //body
      body: StreamBuilder(
        stream: APIs.getClassroomId(),

        //get id of only known users
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              return StreamBuilder(
                stream: APIs.getAllUserClass(
                    snapshot.data?.docs.map((e) => e.id).toList() ?? []),

                //get only those communities, who's ids are provided
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      _list =
                          data?.map((e) => Class.fromJson(e.data())).toList() ??
                              [];
                      log(_list.toString());

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ClassroomCard(user: _list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('Create or Join your first class',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              );
          }
        },
      ),
    );
  }

  // for adding new chat user
  void _addCommunityDialog() {
    String name = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        //title
        title: const Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.deepPurpleAccent,
              size: 28,
            ),
            Text('Add Class')
          ],
        ),

        //content
        content: TextFormField(
          maxLines: null,
          onChanged: (value) => name = value,
          decoration: InputDecoration(
              hintText: 'Class Name',
              prefixIcon:
                  const Icon(Icons.email, color: Colors.deepPurpleAccent),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),

        //actions
        actions: [
          //cancel button
          MaterialButton(
              onPressed: () {
                //hide alert dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 16))),

          //add button
          MaterialButton(
            onPressed: () async {
              //hide alert dialog
              Navigator.pop(context);
              if (name.isNotEmpty) {
                await APIs.addUserToCommunity(name).then((value) {
                  if (!value) {
                    Dialogs.showSnackbar(context, 'Community does not Exists!');
                  }
                });
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
