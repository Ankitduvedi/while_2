import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/classroom/classroom_home_screen.dart';
import 'package:while_app/theme/pallete.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  void themeToggler(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

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
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: currentTheme.scaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            Switch.adaptive(
              value: ref.watch(themeNotifierProvider.notifier).mode ==
                  ThemeMode.light,
              onChanged: (value) => themeToggler(ref),
            ),
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
        body: Text("Hi")
        );
  }
}


