import 'package:flutter/material.dart';
import 'package:real_estate/screens/signin.dart';
import 'package:real_estate/screens/signup.dart';
import 'package:real_estate/screens/form_page.dart';
import 'package:real_estate/screens/stepper_formPage.dart';
import 'package:real_estate/screens/welcome.dart';
import 'package:real_estate/theme/theme.dart';
import 'package:real_estate/screens/home_screen.dart';
import 'package:real_estate/widgets/additionalFeatures.dart';
import 'package:real_estate/widgets/estate_features.dart';
import 'package:real_estate/widgets/opportunities.dart';
import 'package:real_estate/screens/stepper_formPage.dart';
import 'package:real_estate/widgets/select_category.dart';

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
      //home: const WelcomePage(),
      home: StepperPage(),
      routes: {
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/form_page': (context) => FormPage(),
      },
    );
  }
}
