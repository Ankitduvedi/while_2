import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:while_app/resources/components/message/models/chat_user.dart';

import 'dart:io';

import '../../../../main.dart';
import '../apis.dart';
import '../models/community_user.dart';

class ProfileScreenParticipant extends StatefulWidget {
  final CommunityUser user;

  const ProfileScreenParticipant({Key? key, required this.user})
      : super(key: key);

  @override
  State<ProfileScreenParticipant> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenParticipant> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    List<ChatUser> list = [];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.user.name,
            style: const TextStyle(color: Color.fromARGB(255, 43, 21, 21)),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: mq.width, height: mq.height * .03),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * .1),
                              child: Image.file(File(_image!),
                                  width: mq.height * .2,
                                  height: mq.height * .2,
                                  fit: BoxFit.cover))
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(mq.height * .1),
                              child: CachedNetworkImage(
                                width: mq.height * .2,
                                height: mq.height * .2,
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person)),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: mq.height * .03),
                  Text(widget.user.name,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16)),
                  SizedBox(height: mq.height * .02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' Domain: ${widget.user.domain.isNotEmpty ? widget.user.domain : 'No Domain is Mentioned'} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: mq.height * .01),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: const Color.fromARGB(131, 158, 158, 158),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' Email: ${widget.user.email.isNotEmpty ? widget.user.email : 'No Email is Available'} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: mq.height * .01),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: const Color.fromARGB(131, 158, 158, 158),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' About: ${widget.user.about.isNotEmpty ? widget.user.about : 'No Description Available'} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: mq.height * .01),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: const Color.fromARGB(131, 158, 158, 158),
                    ),
                  ),
                  SizedBox(height: mq.height * .02),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' Participants',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: const Color.fromARGB(131, 158, 158, 158),
                    ),
                  ),
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: APIs.getCommunityParticipantsInfo(widget.user.id),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();

                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            list = data
                                    ?.map((e) => ChatUser.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (list.isNotEmpty) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Card(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      color: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            width: 42,
                                            height: 42,
                                            imageUrl: list[index].image,
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.image,
                                                        size: 70),
                                          ),
                                        ),
                                        title: Text(list[index].name),
                                        trailing: Text(widget.user.email ==
                                                list[index].email
                                            ? 'Admin'
                                            : ''),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Text(
                                'No Data to show',
                                style: TextStyle(color: Colors.grey),
                              );
                            }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
