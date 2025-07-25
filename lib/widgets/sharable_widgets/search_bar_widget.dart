import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Added a bit more padding for better appearance
      child: Container(
        // color: Colors.grey[200], // A light grey color
        // You can also add a decoration for a more typical search bar look
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color for the box
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0), // Inner padding for content
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_outlined,
              color: Colors.grey, // Optional: color the icon
            ),
            const SizedBox(width: 8.0), // Space between icon and text
            Expanded( // Allows the text to take available space
              child: Text(
                "Search for products",
                style: TextStyle(
                  color: Colors.grey[500], // Optional: color the text
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}