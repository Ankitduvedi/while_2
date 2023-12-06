import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/classroom/classroom_home_screen.dart';
// import 'package:chewie/chewie.dart';

class VideoItem {
  final String videoUrl;
  final String title;
  final String thumbnailUrl;

  VideoItem({
    required this.videoUrl,
    required this.title,
    required this.thumbnailUrl,
  });
}

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<TestScreen> {
  final List<VideoItem> videoItems = [
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      title: "BigBuckBunny",
      thumbnailUrl: "https://picsum.photos/200/300",
    ),
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      title: "ElephantsDream",
      thumbnailUrl: "https://picsum.photos/200/300",
    ),
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      title: "ElephantsDream",
      thumbnailUrl: "https://picsum.photos/200/300",
    ),
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      title: "ElephantsDream",
      thumbnailUrl: "https://picsum.photos/200/300",
    ),
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      title: "ElephantsDream",
      thumbnailUrl: "https://picsum.photos/200/300",
    ),
    VideoItem(
      videoUrl:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      title: "ElephantsDream",
      thumbnailUrl: "https://picsum.photos/200/300",
    )
    // Add more video items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClassroomScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.menu_book,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // Inside your FeedScreen build method
        body: Text("Hi"));
  }
}
