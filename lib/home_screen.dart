import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naari/widgets/profile_section.dart';
import 'package:naari/widgets/CustomCarouel.dart';
import '../utilis/quotes.dart';
import 'package:naari/widgets/sos_screen.dart';
import 'package:naari/widgets/emergency_contacts_screen.dart';
import 'package:naari/widgets/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int quoteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NAARI'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ProfileSection(user: widget.user!),
              SizedBox(height: 20),
              CustomCarousel(
                articleTitles: articleTitle,
                imageSliders: imageSliders,
                articleLinks: articleLinks,
              ),
              SizedBox(height: 20),
              EmergencyContactsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
