import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_estate/screens/home_screen.dart';
import 'package:real_estate/screens/map_page.dart';
import 'package:real_estate/screens/signin.dart';
import 'package:real_estate/screens/signup.dart';
import 'package:real_estate/screens/form_page.dart';
import 'package:real_estate/screens/welcome.dart';
import 'package:real_estate/theme/theme.dart';
import 'package:real_estate/screens/stepper_formPage.dart';
import 'package:real_estate/screens/settings.dart';
import 'package:real_estate/screens/professionels.dart';
import 'package:real_estate/screens/help_and_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBOngdyzESg55d9sRtlVcHFfNYxbyTCJ3A',
      appId: '1:526785684071:android:4e31921f1cd29a21aeaac2',
      messagingSenderId: '526785684071',
      projectId: 'realestate-412921',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: lightMode,
      home: const WelcomePage(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/form_page': (context) => FormPage(),
        '/map_page': (context) => MapPage(),
        '/professionels': (context) => ProfessionalsScreen(),
        '/settings': (context) => Settings(),
        '/favorites': (context) => MapPage(),
        '/help': (context) => HelpAndSupport(),
      },
    );
  }
}
