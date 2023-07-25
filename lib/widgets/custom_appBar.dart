import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilis/quotes.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import

class CustomAppBar extends StatelessWidget {
  final Function onTap;
  final int quoteIndex;

  CustomAppBar({required this.onTap, required this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Text(
          sweetSayings[quoteIndex],
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans( // Use 'Open Sans' font
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
