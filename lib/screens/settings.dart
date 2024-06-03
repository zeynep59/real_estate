import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/services.dart'; // Import this package for SystemNavigator.pop()
import 'package:real_estate/screens/professionels.dart';

import '../theme/theme.dart';
import 'profile.dart'; // Import the Profile page

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Profile'),
                      subtitle: const Text('Edit your profile details'),
                      onTap: () {
                        // Navigate to profile edit screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Notifications'),
                      subtitle: const Text('Manage your notifications'),
                      trailing: Switch(
                        value: notificationsEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                        activeColor: lightColorScheme.primary,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.palette,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Appearance'),
                      subtitle: const Text('Light and dark mode settings'),
                      trailing: Switch(
                        value: darkModeEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            darkModeEnabled = value;
                          });
                        },
                        activeColor: lightColorScheme.primary,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Help & Support'),
                      subtitle: const Text('Get help and support'),
                      onTap: () {
                        Navigator.pushNamed(context, '/help');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Logout'),
                      onTap: () {
                        // Handle logout
                        Navigator.pushReplacementNamed(
                            context, '/sign_in'); // Redirect to sign-in screen
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          GNav(
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
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: "Favorites",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ],
            selectedIndex: 3, // Ensure the settings tab is selected
            onTabChange: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/map_page');
              } else if (index == 1) {
                Navigator.pushNamed(context, '/professionels');
              } else if (index == 2) {
                Navigator.pushNamed(context, '/favorites');
              } else if (index == 3) {
                Navigator.pushNamed(context, '/settings');
              }
            },
          ),
        ],
      ),
    );
  }
}
