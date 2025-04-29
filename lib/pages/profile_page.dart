import 'package:flutter/material.dart';
import 'package:frontend_laravel/components/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://wallpapersok.com/images/thumbnail/sad-anime-character-filled-with-loneliness-and-despair-v48r8am3qnh1y55u.webp'), // Add your image here
            ),
            SizedBox(height: 20),
            // Name
            Text(
              'John Doe', // Replace with dynamic user name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Email
            Text(
              'johndoe@example.com', // Replace with dynamic email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            // Bio
            Text(
              'This is a short bio of the user. It can be updated in the settings.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),
            // Edit button
            ElevatedButton(
              onPressed: () {
                // Handle edit profile action here
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}