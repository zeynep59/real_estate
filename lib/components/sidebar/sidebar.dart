import 'package:flutter/material.dart';
import 'package:real_estate/screens/signin.dart';
import 'package:real_estate/screens/signup.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.notifications,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title":Text('Notifications',
        style: TextStyle(
          color: Colors.white,
        ),
      ) ,
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 1,
    },
    {
      "leading": Icon(
        Icons.camera_alt_outlined,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Verify Report',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 2,
    },
    {
      "leading": Icon(
        Icons.verified,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Sell with Confidence',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.waving_hand_sharp,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('What Do We Do?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.settings,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Settings',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 4,
    },
    {
      "leading": Icon(
        Icons.question_mark,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Support',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.add_chart_outlined,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Evaluate Us',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.exit_to_app,
        size: 35,
        color: Color(0xFFD7D7D7),
      ),
      "title": Text('Log Out',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      "trailing": Icon(Icons.chevron_right),
      "action_id": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: Container(
            color: const Color(0xFFFE724C), // Arka plan rengi
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFFD7D7D7), // Arka plan rengi
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40, // Profil resminin boyutu
                        backgroundImage: NetworkImage(
                            "https://www.channelfutures.com/files/2019/10/Focus-877x432.jpg"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "BL Kumawat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "7014333352",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ...drawerMenuListname.map((sideMenuData) {
                  return ListTile(
                    leading: sideMenuData['leading'],
                    title: Text(
                      sideMenuData['title'],
                    ),
                    trailing: sideMenuData['trailing'],
                    onTap: () {
                      Navigator.pop(context);
                      if (sideMenuData['action_id'] == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      } else if (sideMenuData['action_id'] == 4) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      }
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
