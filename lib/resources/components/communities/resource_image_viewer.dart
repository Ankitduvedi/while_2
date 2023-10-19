import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;

  ImageViewer(this.imageUrl, this.imageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageTitle),
      ),
      body: Center(
        child: Image.network(imageUrl), // Display the image from the URL
      ),
    );
  }
}
