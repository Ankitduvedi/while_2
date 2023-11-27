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
  late VideoPlayerController _controller0;
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

  @override
  void dispose() {
    _pageController.dispose();
    _controller0.dispose();
    super.dispose();
  }

  Widget text(VideoPlayerController controller1, int index, List<Video> video) {
    controller1.play().whenComplete(
      () {
        _controller2 = VideoPlayerController.networkUrl(
            Uri.parse(video[index + 1].videoUrl))
          ..initialize();
      },
    );
    return FeedItem(video: video[index], index: index, controller: controller1);
  }

  Widget text2(
      VideoPlayerController controller2, int index, List<Video> video) {
    // _controller1.dispose();
    // _controller0.dispose();
    controller2.play().then((value) {
      _controller1 =
          VideoPlayerController.networkUrl(Uri.parse(video[index + 1].videoUrl))
            ..initialize();
    });
    return FeedItem(video: video[index], index: index, controller: controller2);
  }

  @override
  Widget build(BuildContext context) {
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
          videoList.shuffle();
          // print(videoList);
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videoList.length,
            onPageChanged: (int newIndex) {
              videoControllers[_currentPage].dispose();
              setState(() {
                _currentPage = newIndex;
              });
            },
            itemBuilder: (context, index) {
              // final videoData = videoList;
              // return FeedItem(
              //   video: videoList,
              //   index: index,
              // );
              _controller0 = VideoPlayerController.networkUrl(
                  Uri.parse(videoList[index].videoUrl))
                ..initialize();
              return (index % 2 == 0)
                  ? text(index == 0 ? _controller0 : _controller1, index,
                      videoList)
                  : text2(_controller2, index, videoList);
            },
          );
        });
  }
}
