import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/message/models/classroom_user.dart';
import '../message/apis.dart';

const uuid = Uuid();

class AddClassScreen {
  void addCommunityDialog(BuildContext context) {
    String name = '';
    String type = '';
    String domain = '';
    String about = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        scrollable: true,
        elevation: 2,
        contentPadding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        //title
        title: const Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.deepPurpleAccent,
              size: 28,
            ),
            SizedBox(width: 15),
            Text('Create Class')
          ],
        ),

        //content
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //community name
            TextFormField(
              maxLines: null,
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                  hintText: 'Class name',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            //About community
            TextFormField(
              maxLines: null,
              onChanged: (value) => about = value,
              decoration: InputDecoration(
                  hintText: 'Subject',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            //Domain
            TextFormField(
              maxLines: null,
              onChanged: (value) => domain = value,
              decoration: InputDecoration(
                  hintText: 'Room',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: null,
              onChanged: (value) => type = value,
              decoration: InputDecoration(
                  hintText: 'Section',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ],
        ),

        //actions
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //cancel button
              SizedBox(
                width: 90,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 244, 182, 182),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                    ),
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Discard',
                        style: TextStyle(color: Colors.black, fontSize: 16))),
              ),
              //create button
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 90,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 174, 239, 133),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                    ),
                    onPressed: () async {
                      if (type != '' && name != '') {
                        final time =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final String id = uuid.v4();
                        final Class community = Class(
                            about: about,
                            name: name,
                            createdAt: time,
                            id: id,
                            email: APIs.me.email,
                            type: type,
                            noOfUsers: 1,
                            admin: APIs.me.name,
                            clas: '');
                        APIs.addClassroom(
                          community,
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
