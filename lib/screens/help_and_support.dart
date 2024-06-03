import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<StatefulWidget> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Section
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Our application helps you predict real estate prices based on the information you provide. Using advanced algorithms, we analyze various factors to give you an accurate price estimation.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // How it works Section
            Text(
              'How it works',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Enter your property details including location, size, and other relevant information.\n'
              '2. Our algorithm processes the data and compares it with current market trends.\n'
              '3. You receive a predicted price for your property.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // FAQs Section
            Text(
              'FAQs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Q: How accurate is the price prediction?\n'
              'A: Our predictions are based on the latest market data and trends. While we strive for accuracy, please consider our estimates as general guidance.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Q: What information do I need to provide?\n'
              'A: You need to provide details such as property location, size, number of rooms, and other relevant factors.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Contact Us Section
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or need further assistance, please contact us at pricepilot@gmail.com.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
