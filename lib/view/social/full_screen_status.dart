import 'package:flutter/material.dart';

late Size mq;

class FullStatusScreen extends StatelessWidget {
  final Map<String, dynamic> status;

  const FullStatusScreen({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(status['userName'],
            style: const TextStyle(color: Colors.black)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Use Hero widget to create the shared element transition
          Hero(
            tag:
                'status_${status['statusId']}', // Use the same tag as in StatusScreen
            child: Container(
              width: double.infinity,
              height: mq.height * 0.8, // Adjust the size as needed
              decoration: BoxDecoration(
                // Display the full status here, e.g., an image or video
                image: DecorationImage(
                  image: NetworkImage(
                      status['imageUrl']), // Replace with the status image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            status['statusText'],
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
