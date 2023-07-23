import 'package:flutter/material.dart';

class GreetingWidget extends StatefulWidget {
  @override
  _GreetingWidgetState createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  String userName = '';
  String profilePhotoUrl = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, $userName!',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          GestureDetector(
            onTap: _changeProfilePhoto,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: profilePhotoUrl.isEmpty
                  ? null
                  : NetworkImage(profilePhotoUrl),
              child: profilePhotoUrl.isEmpty ? const Icon(Icons.person) : null,
            ),
          ),
        ],
      ),
    );
  }

  void _changeProfilePhoto() {
    // Implement the logic to allow the user to select or change their profile photo
    // This could involve showing a photo picker or camera to capture a new photo
    // Update the profilePhotoUrl variable with the selected photo URL
    setState(() {
      profilePhotoUrl = ''; // Update with the selected photo URL
    });
  }
}
