import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/classroom/class_detail_home.dart';
import 'package:while_app/resources/components/message/models/classroom_user.dart';

late Size mq;

//card to represent a single classroom in home screen
class ClassroomCard extends ConsumerStatefulWidget {
  final Class user;

  const ClassroomCard({super.key, required this.user});

  @override
  ConsumerState<ClassroomCard> createState() => ClassroomCardState();
}

class ClassroomCardState extends ConsumerState<ClassroomCard> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    log(widget.user.name);
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: const Color.fromARGB(255, 239, 238, 224),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () {
              // for navigating to chat screen

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ClassDetailScreen(clas: widget.user)));
            },
            child: ListTile(
                //user name
                title: Text(widget.user.name),
                //Subject
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.user.about),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("${widget.user.noOfUsers.toString()} participants"),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),

                //last message time
                trailing: Text(widget.user.admin))));
  }
}
