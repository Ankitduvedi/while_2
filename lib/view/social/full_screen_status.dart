import 'package:flutter/material.dart';

class FullStatusScreen extends StatelessWidget {
  final Map<String, dynamic> status;

  const FullStatusScreen({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use Hero widget to create the shared element transition
          Hero(
            tag:
                'status_${status['statusId']}', // Use the same tag as in StatusScreen
            child: Container(
              width: double.infinity,
              height: 300, // Adjust the size as needed
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
