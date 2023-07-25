import 'package:flutter/material.dart';
// import 'package:naari/widgets/custom_appBar.dart';
import 'package:naari/widgets/CustomCarouel.dart';
import '../utilis/quotes.dart';

import 'package:naari/widgets/emergency_contacts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int quoteIndex = 0;

  // void _changeQuote() {
  //   setState(() {
  //     quoteIndex = (quoteIndex + 1) % sweetSayings.length;
  //   });
  // }

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
              // CustomAppBar(
              //   onTap: _changeQuote,
              //   quoteIndex: quoteIndex,
              // ),
              // SizedBox(height: 20),
              CustomCarousel(
                articleTitles: articleTitle,
                imageSliders: imageSliders,
                articleLinks: articleLinks,
              ),
              SizedBox(height: 20), // Add some spacing between the carousel and emergency contacts
              EmergencyContactsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
