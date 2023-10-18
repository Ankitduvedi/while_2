import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/bottom_options_sheet.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/models/chat_user.dart';

late Size mq;

class FriendProfileDataWidget extends StatefulWidget {
  const FriendProfileDataWidget({super.key, required this.chatUser});
  final ChatUser chatUser;
  @override
  State<FriendProfileDataWidget> createState() =>
      FriendProfileDataWidgetState();
}

class FriendProfileDataWidgetState extends State<FriendProfileDataWidget> {
  String? _image;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var nh = MediaQuery.of(context).viewPadding.top;
    return StreamBuilder(
        stream: APIs.getSelfData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const SizedBox();

            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              ChatUser user = ChatUser.fromJson(data![0].data());

              return SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: h / 2.5,
                    ),
                    Positioned(
                      top: nh,
                      child: InkWell(
                          child: ClipRRect(
                        // borderRadius: BorderRadius.circular(h * .13),
                        child: CachedNetworkImage(
                          width: h,
                          fit: BoxFit.cover,
                          height: h * .13,
                          imageUrl: widget.chatUser.image,
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                      )),
                    ),
                    Positioned(
                      top: nh + h / 7 - w / 8,
                      left: w / 12,

                      //profile picture
                      child: _image != null
                          ?
                          //local image
                          ClipRRect(
                              borderRadius: BorderRadius.circular(h * .1),
                              child: Image.file(File(_image!),
                                  width: h * .1,
                                  height: h * .1,
                                  fit: BoxFit.cover))
                          :
                          //image from server
                          ClipRRect(
                              borderRadius: BorderRadius.circular(h * .75),
                              child: CachedNetworkImage(
                                width: h * .15,
                                height: h * .15,
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.fill,
                                imageUrl: widget.chatUser.image,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person)),
                              ),
                            ),
                    ),
                    Positioned(
                        top: nh + h / 7 + 5,
                        left: w / 2.25,
                        child: const Text(
                          "Followers",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    Positioned(
                        top: nh + h / 7 + 5,
                        left: w / 1.5,
                        child: const Text(
                          "Following",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    Positioned(
                        top: nh + h / 7.5,
                        left: w / 1.15,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MoreOptions(
                                      user: user,
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ))),
                    Positioned(
                        top: nh + h / 7 + 24,
                        left: w / 2.25,
                        child: const Text(
                          "320",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    Positioned(
                        top: nh + h / 7 + 24,
                        left: w / 1.5,
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.chatUser.id)
                                .collection('my_users')
                                .get(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                //if data is loading
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const SizedBox();

                                //if some or all data is loaded then show it
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  return Text(
                                      snapshot.data!.docs.length.toString());
                              }
                            })),
                    Positioned(
                      top: nh + h / 7 + w / 8 + 30,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.chatUser.name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            Text(widget.chatUser.about,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        });
  }
}
