import 'package:flutter/material.dart';
import 'package:real_estate/widgets/custom_scaffold.dart';
import 'package:real_estate/widgets/welcome_button.dart';
import 'package:real_estate/screens/signin.dart';
import 'package:real_estate/screens/signup.dart';
import 'package:real_estate/theme/theme.dart';
import 'package:real_estate/screens/form_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Welcome to Real Estate deneme123',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Find your dream home with us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_in');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_up');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(height: 20), // Added space before the additional button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/form_page');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor:
                      Colors.transparent, // Set background color to transparent
                  shadowColor:
                      Colors.transparent, // Set shadow color to transparent
                  elevation: 0, // Set elevation to 0 to remove shadow
                ),
                child: Text(
                  'map', // Customize text as needed
                  style: TextStyle(
                    color: Colors.white, // Set text color to blue
                    fontSize: 18,
                    decoration: TextDecoration.underline, // Underline the text
                  ),
                ),
              ),
              SizedBox(height: 20), // Added space before the additional button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/form_page');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor:
                      Colors.transparent, // Set background color to transparent
                  shadowColor:
                      Colors.transparent, // Set shadow color to transparent
                  elevation: 0, // Set elevation to 0 to remove shadow
                ),
                child: Text(
                  'form', // Customize text as needed
                  style: TextStyle(
                    color: Colors.white, // Set text color to blue
                    fontSize: 18,
                    decoration: TextDecoration.underline, // Underline the text
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
