import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naari/widgets/profile_section.dart';
import 'package:naari/widgets/CustomCarouel.dart';
import '../utilis/quotes.dart';
import 'package:naari/widgets/emergency_contacts_screen.dart';
import 'package:naari/widgets/profile_screen.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({Key? key, this.user}) : super(key: key);

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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: widget.user!),
                ),
              );
            },
          ),
        ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _sendSosMessage(context),
        label: Text('SOS'),
        icon: Icon(Icons.warning),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<void> _sendSosMessage(BuildContext context) async {
    try {
      String message = 'Emergency! I need your help.';
      List<String> recipients = await _fetchEmergencyContacts();

      if (recipients.isNotEmpty) {
        await _launchSms(message, recipients);
      } else {
        print('No emergency contacts available.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> _fetchEmergencyContacts() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          List<dynamic>? emergencyContacts =
          userDoc['emergencyContacts'] as List<dynamic>?;

          if (emergencyContacts != null && emergencyContacts.isNotEmpty) {
            List<String> contactNumbers =
            emergencyContacts.map((contact) => contact.toString()).toList();

            print('Emergency Contacts: $contactNumbers');
            return contactNumbers;
          } else {
            print('No emergency contacts found for user: ${user.uid}');
            return [];
          }
        } else {
          print('User document not found');
          return [];
        }
      } else {
        print('User not authenticated');
        return [];
      }
    } catch (e) {
      print('Error fetching emergency contacts: $e');
      return [];
    }
  }



  Future<void> _launchSms(String message, List<String> recipients) async {
    try {
      String recipientsString = recipients.join(',');
      String encodedMessage = Uri.encodeFull(message);

      String uri = 'sms:$recipientsString?body=$encodedMessage';

      await launch(uri);
    } catch (e) {
      print('Error launching SMS: $e');
    }
  }
}
