// import 'dart:developer';
// import 'dart:io';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:while_app/resources/components/classroom/class_message.dart';
// import 'package:while_app/resources/components/communities/community_message.dart';
// import 'package:while_app/resources/components/communities/community_message_card.dart';
// import 'package:while_app/resources/components/message/models/classroom_user.dart';
// import '../message/apis.dart';

// late Size mq;

// class CChatScreen extends StatefulWidget {
//   final Class user;

//   const CChatScreen({super.key, required this.user});

//   @override
//   State<CChatScreen> createState() => _CChatScreenState();
// }

// class _CChatScreenState extends State<CChatScreen> {
//   //for storing all messages
//   List<ClassMessage> _list = [];

//   //for handling message text changes
//   final _textController = TextEditingController();

//   //showEmoji -- for storing value of showing or hiding emoji
//   //isUploading -- for checking if image is uploading or not?
//   bool _showEmoji = false, _isUploading = false;

//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
//         //if emojis are shown & back button is pressed then hide emojis
//         //or else simple close current screen on back button click
//         onWillPop: () {
//           if (_showEmoji) {
//             setState(() => _showEmoji = !_showEmoji);
//             return Future.value(false);
//           } else {
//             return Future.value(true);
//           }
//         },
//         child: Scaffold(
//           backgroundColor: Colors.white,

//           //body
//           body: Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder(
//                   stream: APIs.getAllClassMessages(widget.user),
//                   builder: (context, snapshot) {
//                     switch (snapshot.connectionState) {
//                       //if data is loading
//                       case ConnectionState.waiting:
//                       case ConnectionState.none:
//                         return const SizedBox();

//                       //if some or all data is loaded then show it
//                       case ConnectionState.active:
//                       case ConnectionState.done:
//                         final data = snapshot.data?.docs;
//                         _list = data
//                                 ?.map(
//                                     (e) => ClassMessage.fromJson(e.data()))
//                                 .toList() ??
//                             [];

//                         if (_list.isNotEmpty) {
//                           return ListView.builder(
//                               reverse: true,
//                               itemCount: _list.length,
//                               padding: EdgeInsets.only(top: mq.height * .01),
//                               physics: const BouncingScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 // return CommunityMessageCard(
//                                 //     message: _list[index]);
//                               });
//                         } else {
//                           return const Center(
//                             child: Text('Say Hii! 👋',
//                                 style: TextStyle(fontSize: 20)),
//                           );
//                         }
//                     }
//                   },
//                 ),
//               ),

//               //progress indicator for showing uploading
//               if (_isUploading)
//                 const Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//                         child: CircularProgressIndicator(strokeWidth: 2))),

//               //chat input filed
//               _chatInput(context),

//               //show emojis on keyboard emoji button click & vice versa
//               if (_showEmoji)
//                 SizedBox(
//                   height: mq.height * .35,
//                   child: EmojiPicker(
//                     textEditingController: _textController,
//                     config: Config(
//                       bgColor: const Color.fromARGB(255, 234, 248, 255),
//                       columns: 8,
//                       emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // bottom chat input field
//   Widget _chatInput(BuildContext context) {
//     log('////height');

//     log(mq.height.toString());
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: mq.height * 0, horizontal: mq.width * .025),
//       child: Row(
//         children: [
//           //input field & buttons
//           Expanded(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Row(
//                 children: [
//                   //emoji button
//                   IconButton(
//                       onPressed: () {
//                         FocusScope.of(context).unfocus();
//                         setState(() => _showEmoji = !_showEmoji);
//                       },
//                       icon: const Icon(Icons.emoji_emotions,
//                           color: Colors.blueAccent, size: 25)),

//                   Expanded(
//                       child: TextField(
//                     controller: _textController,
//                     keyboardType: TextInputType.multiline,
//                     style: const TextStyle(color: Colors.black),
//                     maxLines: null,
//                     onTap: () {
//                       if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
//                     },
//                     decoration: const InputDecoration(
//                         counterStyle: TextStyle(color: Colors.black),
//                         fillColor: Colors.black,
//                         hintText: 'Type Something...',
//                         hintStyle: TextStyle(color: Colors.black),
//                         border: InputBorder.none),
//                   )),

//                   //pick image from gallery button
//                   IconButton(
//                       onPressed: () async {
//                         final ImagePicker picker = ImagePicker();

//                         // Picking multiple images
//                         final List<XFile> images =
//                             await picker.pickMultiImage(imageQuality: 70);

//                         // uploading & sending image one by one
//                         for (var i in images) {
//                           log('Image Path: ${i.path}');
//                           setState(() => _isUploading = true);
//                           await APIs.communitySendChatImage(
//                               widget.user, File(i.path));
//                           setState(() => _isUploading = false);
//                         }
//                       },
//                       icon: const Icon(Icons.image,
//                           color: Colors.blueAccent, size: 26)),

//                   //take image from camera button
//                   IconButton(
//                       onPressed: () async {
//                         final ImagePicker picker = ImagePicker();

//                         // Pick an image
//                         final XFile? image = await picker.pickImage(
//                             source: ImageSource.camera, imageQuality: 70);
//                         if (image != null) {
//                           log('Image Path: ${image.path}');
//                           setState(() => _isUploading = true);

//                           await APIs.communitySendChatImage(
//                               widget.user, File(image.path));
//                           setState(() => _isUploading = false);
//                         }
//                       },
//                       icon: const Icon(Icons.camera_alt_rounded,
//                           color: Colors.blueAccent, size: 26)),

//                   //adding some space
//                   SizedBox(width: mq.width * .02),
//                 ],
//               ),
//             ),
//           ),

//           //send message button
//           MaterialButton(
//             onPressed: () {
//               if (_textController.text.isNotEmpty) {
//                 APIs.sendCommunityMessage(
//                     widget.user, _textController.text, Types.text);
//                 // }
//                 _textController.text = '';
//               }
//             },
//             minWidth: 0,
//             padding:
//                 const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
//             shape: const CircleBorder(),
//             color: const Color.fromARGB(255, 76, 175, 173),
//             child: const Icon(Icons.send, color: Colors.white, size: 28),
//           )
//         ],
//       ),
//     );
//   }
// }
