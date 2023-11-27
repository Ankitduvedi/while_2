import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/helper/dialogs.dart';
import 'package:while_app/resources/components/message/models/reels_models.dart';
import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';
import 'package:while_app/resources/components/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:while_app/utils/utils.dart';
import 'package:while_app/view_model/session_controller.dart';
import 'dart:async';

class AddReel extends StatefulWidget {
  final String video;
  const AddReel({Key? key, required this.video}) : super(key: key);

  @override
  State<AddReel> createState() => _AddReelState();
}

class _AddReelState extends State<AddReel> {
  late Subscription _subscription;
  bool isloading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      isloading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.unsubscribe();
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.LowQuality, deleteOrigin: false);
    return compressedVideo!.file;
  }

  void uploadVideo(BuildContext context, String title, String des, String path,
      List likes, int shares) async {
    setState(() {
      isloading = true;
    });

    DateTime now = DateTime.now();
    // File video = _compressVideo(path);
    File video = File(path);
    var stream = http.ByteStream(video.openRead().cast());
    var length = video.lengthSync();
    var uri = Uri.parse('http://13.233.151.213:3000/reels');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile('video', stream, length,
          filename: basename(video.path)));
    // await request.send();
    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        // Parse the URL from the response
        // final Map<String, dynamic> jsonResponse =
        String videoUrl = json.decode(response.body);
        Dialogs.showSnackbar(context, videoUrl);
        final CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('videos');
        final Map<String, dynamic> vid = {
          "uploadedBy": APIs.me.id,
          'videoUrl': videoUrl,
          'title': title,
          'description': des,
          'likes': [],
          'views': 0
        };
        collectionReference.add(vid).then((value) {
          // Utils.toastMessage('Your video is uploaded!');
          setState(() {
            isloading = false;
          });
          Navigator.pop(context);
        }).onError((error, stackTrace) {
          Utils.toastMessage(error.toString());
        });
        // Now you can use the videoUrl as needed, for example, storing it in a variable or database
        print('Uploaded video URL: $videoUrl');

        // You can use the videoUrl as needed, for example, store it in a variable, database, etc.
        // You can then use this URL to display the video or perform other operations.
      } else {
        print('Failed to upload video. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading video: $error');
    }

    print(url);

    // firebase_storage.Reference storageRef = firebase_storage
    //     .FirebaseStorage.instance
    //     .ref('content/${FirebaseSessionController().uid!}/video/$now');
    // firebase_storage.UploadTask uploadTask =
    //     storageRef.putFile(await _compressVideo(path));

    // await Future.value(uploadTask);

    // final newUrl = await storageRef.getDownloadURL();
    final user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 1;
    final w = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reel"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: w,
                  height: h / 2,
                  child: VideoPlayerWidget(videoPath: widget.video),
                ),
              ),
              const SizedBox(height: 15),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _titleController,
                prefixIcon: Icons.title,
                hintText: 'Title',
              ),
              const SizedBox(height: 10),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                prefixIcon: Icons.description,
                hintText: 'Description',
              ),
              const SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: "Add Reel",
                  loading: isloading,
                  onPress: () {
                    if (_titleController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter title', context);
                    } else if (_descriptionController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter description', context);
                    } else {
                      uploadVideo(
                          context,
                          _titleController.text.toString(),
                          _descriptionController.text.toString(),
                          widget.video.toString(),
                          [], // initally the likes list shall be holding an empty list to be precise
                          0);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
