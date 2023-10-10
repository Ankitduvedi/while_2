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
  _FullStatusScreenState createState() => _FullStatusScreenState();
}

class _FullStatusScreenState extends State<FullStatusScreen> {
  int currentIndex = 0;
  Timer? statusTimer;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    startTimer();
  }

  @override
  void dispose() {
    statusTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    statusTimer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (currentIndex < widget.statuses.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  void resetTimer() {
    statusTimer?.cancel();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final status = widget.statuses[currentIndex];
    final timestamp = status['timestamp'] as Timestamp;
    final dateTime = timestamp.toDate();
    final formattedDate = DateFormat.yMd().add_Hms().format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          status['userName'],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: resetTimer,
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0 && currentIndex > 0) {
            setState(() {
              currentIndex--;
              resetTimer();
            });
          } else if (details.velocity.pixelsPerSecond.dx < 0 &&
              currentIndex < widget.statuses.length - 1) {
            setState(() {
              currentIndex++;
              resetTimer();
            });
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.statuses.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              resetTimer();
            });
          },
          itemBuilder: (context, index) {
            final status = widget.statuses[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
