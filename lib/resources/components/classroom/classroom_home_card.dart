import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/message/models/classroom_user.dart';
import '../communities/community_message.dart';
import '../message/apis.dart';
import '../message/helper/my_date_util.dart';

late Size mq;

//card to represent a single classroom in home screen
class ClassroomCard extends ConsumerStatefulWidget {
  final Class user;

  const ClassroomCard({super.key, required this.user});

  @override
  ConsumerState<ClassroomCard> createState() => ClassroomCardState();
}

class ClassroomCardState extends ConsumerState<ClassroomCard> {
  //last message info (if null --> no message)
  CommunityMessage? _message;

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
            // onTap: () {
            //   // for navigating to chat screen

            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) => CCommunityDetailScreen(user: widget.user)));
            // },
            child: ListTile(
          //user name
          title: Text(widget.user.name),

          //last message
          subtitle: Text(widget.user.admin),

          //last message time
          trailing: _message == null
              ? null //show nothing when no message is sent
              : _message!.read.isEmpty && _message!.fromId != APIs.user.uid
                  ?
                  //show for unread message
                  Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade400,
                          borderRadius: BorderRadius.circular(10)),
                    )
                  :
                  //message sent time
                  Text(
                      MyDateUtil.getLastMessageTime(
                          context: context, time: _message!.sent),
                      style: const TextStyle(color: Colors.black54),
                    ),
        )));
  }
}
