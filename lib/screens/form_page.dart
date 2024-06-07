import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: const Color(0xFF272D2F),
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        tabBackgroundColor: Colors.grey.shade800,
        activeColor: Colors.white,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.people_outline_rounded,
            text: "Professionals",
          ),
          GButton(
            icon: Icons.history,
            text: "History",
          ),
          GButton(
            icon: Icons.settings,
            text: "Settings",
          ),
        ],
      ),
    );
  }
}
