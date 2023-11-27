import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naari/widgets/profile_screen.dart';

class ProfileSection extends StatelessWidget {
  final User user;

  const ProfileSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          // You can display the user's profile image here
          radius: 40,
          backgroundImage: NetworkImage(user.photoURL ?? ''),
        ),
        SizedBox(height: 16),
        Text(
          'Welcome, ${user.displayName ?? 'User'}!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Navigate to the profile editing screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(user: user),
              ),
            );
          },
          child: Text('Edit Profile'),
        ),
      ],
    );
  }
}
