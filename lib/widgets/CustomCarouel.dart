// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class CustomCarousel extends StatefulWidget {
//   final List<String> articleTitles;
//   final List<String> imageSliders;
//
//   CustomCarousel({required this.articleTitles, required this.imageSliders, required List<String> articleLinks});
//
//   @override
//   _CustomCarouselState createState() => _CustomCarouselState();
// }
//
// class _CustomCarouselState extends State<CustomCarousel> {
//   int _currentSlide = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding here
//           child: CarouselSlider.builder(
//             itemCount: widget.articleTitles.length,
//             options: CarouselOptions(
//               height: 200,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 5),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _currentSlide = index;
//                 });
//               },
//               enlargeCenterPage: true, // Add animation to enlarge the center slide
//               viewportFraction: 0.8, // Adjust the value for the distance between slide
//             ),
//             itemBuilder: (context, index, realIndex) {
//               final articleTitle = widget.articleTitles[index];
//               final imageSlider = widget.imageSliders[index];
//               return buildSlide(articleTitle, imageSlider);
//             },
//           ),
//         ),
//         SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: widget.articleTitles.map((title) {
//             int index = widget.articleTitles.indexOf(title);
//             return buildIndicator(index);
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget buildSlide(String articleTitle, String imageSlider) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Stack(
//           children: [
//             Image.network(
//               imageSlider,
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//                 child: Text(
//                   articleTitle,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildIndicator(int index) {
//     return Container(
//       width: 8,
//       height: 8,
//       margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _currentSlide == index ? Colors.blue : Colors.grey,
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> articleTitles;
  final List<String> imageSliders;
  final List<String> articleLinks;

  CustomCarousel({required this.articleTitles, required this.imageSliders, required this.articleLinks});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.articleTitles.length,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          itemBuilder: (context, index, realIndex) {
            final articleTitle = widget.articleTitles[index];
            final imageSlider = widget.imageSliders[index];
            final articleLink = widget.articleLinks[index];
            return buildSlide(articleTitle, imageSlider, articleLink);
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.articleTitles.map((title) {
            int index = widget.articleTitles.indexOf(title);
            return buildIndicator(index);
          }).toList(),
        ),
      ],
    );
  }

  Widget buildSlide(String articleTitle, String imageSlider, String articleLink) {
    return GestureDetector(
      onTap: () {
        launchURL(articleLink);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                imageSlider,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    articleTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentSlide == index ? Colors.blue : Colors.grey,
      ),
    );
  }

  // void launchURL(String url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }
}

