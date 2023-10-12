import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

late Size mq;

class FullStatusScreen extends StatefulWidget {
  final List<Map<String, dynamic>> statuses;
  final int initialIndex;

  const FullStatusScreen({
    required this.statuses,
    required this.initialIndex,
    super.key,
  });

  @override
  FullStatusScreenState createState() => FullStatusScreenState();
}

class FullStatusScreenState extends State<FullStatusScreen> {
  int currentIndex = 0;
  Timer? statusTimer;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
    startTimer();
  }

  @override
  void dispose() {
    statusTimer?.cancel();
    pageController!.dispose();
    super.dispose();
  }

  void startTimer() {
    statusTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentIndex < widget.statuses.length - 1) {
        setState(() {
          currentIndex++;
        });
        pageController!.animateToPage(
          currentIndex,
          duration:
              const Duration(milliseconds: 300), // Optional animation duration
          curve: Curves.easeInOut, // Optional animation curve
        );
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final status = widget.statuses[currentIndex];
    final timestamp = status['timestamp'] as Timestamp;
    final dateTime = timestamp.toDate();
    final formattedDate = DateFormat.yMd().add_Hms().format(dateTime);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          status['userName'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Reset the timer and navigate to the next status manually
          statusTimer?.cancel();
          if (currentIndex < widget.statuses.length - 1) {
            setState(() {
              currentIndex++;
            });
            pageController!.animateToPage(
              currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            startTimer(); // Start the timer again
          } else {
            Navigator.pop(context);
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.statuses.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final status = widget.statuses[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Display the full status here, e.g., an image or video
                CachedNetworkImage(
                  width: double.infinity,
                  height: mq.height * .7,
                  fit: BoxFit.contain,
                  imageUrl: status['imageUrl'],
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
                const SizedBox(height: 16.0),
                Text(
                  status['statusText'],
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
