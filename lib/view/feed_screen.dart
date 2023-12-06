import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/classroom/classroom_home_screen.dart';
// import 'package:chewie/chewie.dart';
import 'package:while_app/view/testing_screen.dart';

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

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
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

  final List<String> images = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/300/300',
    'https://picsum.photos/200/310',
    'https://via.placeholder.com/300',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   //backgroundColor: currentTheme.scaffoldBackgroundColor,
        //   backgroundColor: Colors.black,
        //   elevation: 0.0,
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) => const ClassroomScreen(),
        //           ),
        //         );
        //       },
        //       icon: const Icon(
        //         Icons.menu_book,
        //         color: Colors.white,
        //       ),
        //     ),
        //     IconButton(
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => const TestScreen(),
        //           ));
        //         },
        //         icon: const Icon(
        //           Icons.abc_outlined,
        //           color: Colors.white,
        //         ))
        //   ],
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //padding: EdgeInsets.all(15),
                  height: 230,
                  //color: Colors.amber,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        // Handle page change
                      },
                    ),
                    items: images.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: Image.network(item, fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    const Text(
                      'Trending',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: videoItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => VideoPlayerScreen(
                          //       videoUrl: videoItems[index].videoUrl,
                          //       videoTitle: videoItems[index].title,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Card(
                          color: Colors.black,
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            videoItems[index].thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  videoItems[index].title,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    const Text(
                      'Web Development',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: videoItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          // MaterialPageRoute(
                          //   builder: (context) => VideoPlayerScreen(
                          //     videoUrl: videoItems[index].videoUrl,
                          //     videoTitle: videoItems[index].title,
                          //   ),
                          // ),
                          // );
                        },
                        child: Card(
                          color: Colors.black,
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            videoItems[index].thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  videoItems[index].title,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    const Text(
                      'App Development',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: videoItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          // MaterialPageRoute(
                          //   builder: (context) => VideoPlayerScreen(
                          //     videoUrl: videoItems[index].videoUrl,
                          //     videoTitle: videoItems[index].title,
                          //   ),
                          // ),
                          // );
                        },
                        child: Card(
                          color: Colors.black,
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            videoItems[index].thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  videoItems[index].title,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    const Text(
                      'Machine Learning',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: videoItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => VideoPlayerScreen(
                          //       videoUrl: videoItems[index].videoUrl,
                          //       videoTitle: videoItems[index].title,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Card(
                          color: Colors.black,
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            videoItems[index].thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  videoItems[index].title,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    const Text(
                      'Management',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                  height: 150,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 9 / 12,
                    ),
                    itemCount: videoItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => VideoPlayerScreen(
                          //       videoUrl: videoItems[index].videoUrl,
                          //       videoTitle: videoItems[index].title,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Card(
                          color: Colors.black,
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            videoItems[index].thumbnailUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  videoItems[index].title,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;
//   final String videoTitle;

//   const VideoPlayerScreen({
//     Key? key,
//     required this.videoUrl,
//     required this.videoTitle,
//   }) : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();

//     _chewieController = ChewieController(
//       videoPlayerController: VideoPlayerController.networkUrl(
//         Uri.parse(widget.videoUrl),
//       ),
//       autoPlay: true,
//       looping: false,
//       showControls: true,
//       aspectRatio: 16 / 9,
//       placeholder: Container(
//         color: Colors.black,
//       ),
//       autoInitialize: true,
//     );
//   }

//   @override
//   void dispose() {
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.videoTitle),
//       ),
//       body: Chewie(controller: _chewieController),
//     );
//   }
// }
