import 'package:flutter/material.dart';
import 'package:real_estate/screens/welcome.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PricePilot',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFE724C)),
          useMaterial3: true),
      home: const Welcome(),
    );
  }
}
