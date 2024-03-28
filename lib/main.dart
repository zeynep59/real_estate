import 'package:flutter/material.dart';
import 'package:real_estate/screens/signin.dart';
import 'package:real_estate/screens/signup.dart';
import 'package:real_estate/screens/welcome.dart';
import 'package:real_estate/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const WelcomePage(),
      routes: {
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
      },
    );
  }
}
