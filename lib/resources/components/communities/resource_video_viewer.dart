// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoViewer extends StatefulWidget {
//   final String videoUrl;

//   VideoViewer(this.videoUrl);

//   @override
//   _VideoViewerState createState() => _VideoViewerState();
// }

// class _VideoViewerState extends State<VideoViewer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     Uri videoUri = Uri.parse(widget.videoUrl); // Create a Uri object from the URL
//     _controller = VideoPlayerController.networkUrl(videoUri)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Viewer'),
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
