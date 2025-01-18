import 'package:flutter/material.dart';
import 'dart:io';

class ImageWithTextComponent extends StatelessWidget {
  static String routeName = "/PhotoDisplay";
  final File imageFile;
  final String text; // Single input for the text content

  ImageWithTextComponent({
    required this.imageFile,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image display with specific height
        Container(
          height: 250.0, // Set the fixed height for the image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(imageFile), // Display the captured image
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
        ),

        // Space between the image and text
        SizedBox(height: 20.0),

        // Text display with custom styles
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Text(
            text, // Display the entire text passed as input
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              height: 1.5, // Line height for readability
            ),
            textAlign:
                TextAlign.justify, // Justify the text for better alignment
          ),
        ),
      ],
    );
  }
}
