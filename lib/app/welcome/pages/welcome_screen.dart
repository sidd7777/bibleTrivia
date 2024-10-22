import 'package:bible_trivia/app/homepage/pages/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../model/user_model.dart';

class WelcomeScreen extends StatelessWidget {
  final String userId;
  final List<String> imgList = [
    'assets/images/google.png',
    'assets/images/facebook.jpeg',
    'assets/images/flutter_new_logo.png',
  ];

  final List<String> textList = [
    'Welcome to Bible Trivia!',
    'Test your knowledge of the Bible!',
    'Join us for fun and learning!',
  ];

  WelcomeScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    UserModel.updateWelcomeScreenSeen(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
        ),
      ),
      body: Column(
        children: [
          // Display text first
          Expanded(
            child: ListView.builder(
              itemCount: textList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    textList[index],
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          // Carousel for images
          Expanded(
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgList[itemIndex]),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                height: 400.0, // Adjust height as needed
                autoPlayInterval: Duration(seconds: 3), // Duration between auto plays
                autoPlayAnimationDuration: Duration(milliseconds: 1000), // Animation duration
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login page
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            title: AppTheme.appBarTitleText,
                          )), // Adjust as needed
                );
              },
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
