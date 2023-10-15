import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/communities/cdetail.dart';
import '../communities/community_message.dart';
import '../communities/community_user.dart';
import '../message/apis.dart';
import '../message/helper/my_date_util.dart';

late Size mq;

//card to represent a single classroom in home screen
class ClassroomCard extends ConsumerStatefulWidget {
  final CommunityUser user;

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
          onTap: () {
            // for navigating to chat screen

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CCommunityDetailScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastCommunityMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list = data
                      ?.map((e) => CommunityMessage.fromJson(e.data()))
                      .toList() ??
                  [];
              if (list.isNotEmpty) {
                _message = list[0];
              }

              return ListTile(
                //user name
                title: Text(widget.user.name),

                //last message
                subtitle: Text(
                    _message != null
                        ? _message!.types == Types.image
                            ? 'image'
                            : _message!.msg
                        : widget.user.about,
                    maxLines: 1),

                //last message time
                trailing: _message == null
                    ? null //show nothing when no message is sent
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
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
              );
            },
          )),
    );
  }
}
