import 'package:flutter/material.dart';

class TextPasswordContainerWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String hintText;
  final Color backgroundColor; // Add a new parameter for background color

  const TextPasswordContainerWidget(
      {required this.controller,
      required this.keyboardType,
      required this.prefixIcon,
      required this.hintText,
      this.backgroundColor = Colors.white,
      super.key // Default to white
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Use the provided background color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: true,
        style: const TextStyle(color: Colors.black), // Customize text color
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
