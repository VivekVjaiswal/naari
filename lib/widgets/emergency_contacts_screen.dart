import 'package:flutter/material.dart';
import 'package:naari/widgets/emergency_contacts.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGradientButton(
              'Police',
              Icons.local_police, // Icon for Police
              EmergencyContacts.police,
              [Colors.redAccent, Colors.pinkAccent],
            ),
            SizedBox(width: 10),
            _buildGradientButton(
              'Fire Brigade',
              Icons.local_fire_department, // Icon for Fire Brigade
              EmergencyContacts.fireBrigade,
              [Colors.orangeAccent, Colors.deepOrangeAccent],
            ),
            SizedBox(width: 10),
            _buildGradientButton(
              'Ambulance',
              Icons.local_hospital, // Icon for Ambulance
              EmergencyContacts.ambulance,
              [Colors.blueAccent, Colors.lightBlueAccent],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(String title, IconData iconData, String phoneNumber, List<Color> colors) {
    return ElevatedButton(
      onPressed: () => launch('tel:$phoneNumber'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row( // Wrap the text and icon in a Row
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 24, color: Colors.white), // Icon
            SizedBox(width: 8),
            Text(
              title + ': $phoneNumber',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
