import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:while_app/controller/feed_item.dart';
import 'package:while_app/controller/videos_lists.dart';
import 'package:while_app/data/model/video_model.dart';
import '../utils/data_provider.dart';
import 'package:provider/provider.dart' as provi;

class ReelsScreen extends ConsumerStatefulWidget {
  const ReelsScreen({super.key});
  // final Stream video
  @override
  ConsumerState<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends ConsumerState<ReelsScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final currentTheme = ref.watch(themeNotifierProvider);
    List<VideoPlayerController> videoControllers = [];
    Stream<QuerySnapshot> str =
        provi.Provider.of<DataProvider>(context).videoStream;
    return StreamBuilder<QuerySnapshot>(
        stream: str,
        // stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        // initialData: ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final List<Video> videoList = VideoList.getVideoList(snapshot.data!);
          // print(videoList);
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videoList.length,
            onPageChanged: (int newIndex) {
              videoControllers[_currentPage].pause();
              setState(() {
                _currentPage = newIndex;
              });
            },
            itemBuilder: (context, index) {
              final videoData = videoList[index];
              return FeedItem(video: videoData);
            },
          );
        });
  }
}
