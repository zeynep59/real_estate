import 'package:flutter/material.dart';
import 'package:real_estate/widgets/custom_scaffold.dart';
import '../theme/theme.dart';

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
    return CustomScaffold(
      child: Column(
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
                        Icons.lock,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Privacy'),
                      subtitle: const Text('Privacy and security settings'),
                      onTap: () {
                        // Navigate to privacy settings screen
                      },
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
                        Icons.language,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Language'),
                      subtitle: const Text('Choose your preferred language'),
                      onTap: () {
                        // Navigate to language settings screen
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        color: lightColorScheme.primary,
                      ),
                      title: const Text('Help & Support'),
                      subtitle: const Text('Get help and support'),
                      onTap: () {
                        // Navigate to help and support screen
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
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
