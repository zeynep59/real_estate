import 'package:flutter/material.dart';
import 'package:real_estate/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/models/professionel.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfessionalsScreen extends StatefulWidget {
  @override
  _ProfessionalsScreenState createState() => _ProfessionalsScreenState();
}

class _ProfessionalsScreenState extends State<ProfessionalsScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  late Future<List<Professional>> _professionalsFuture = Future.value([]);
  int _selectedIndex = 1;  // Assuming 'Professionals' is at index 1

  @override
  void initState() {
    super.initState();
    _authenticateAndFetchData();
  }

  Future<void> _authenticateAndFetchData() async {
    print('Authenticating...');
    var user =
    await _authService.signInWithEmailAndPassword('1@gmail.com', '123123');
    if (user != null) {
      print('User authenticated: ${user.email}');
      setState(() {
        _professionalsFuture = _authService.fetchProfessionals();
      });
    } else {
      print('Authentication failed');
    }
  }

  void _onTabChange(int index) {
      setState(() {
        if (index == 0) {
          Navigator.pushNamed(context, '/map_page');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/professionels');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/history');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/settings');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Text('Professionals'),
      ),
      body: FutureBuilder<List<Professional>>(
        future: _professionalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<Professional> professionals = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: professionals.length,
            itemBuilder: (context, index) {
              Professional professional = professionals[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 145,  // Adjust the height to provide more space for text content
                      width: 300,
                      child: professional.photo.isNotEmpty
                          ? Image.asset(
                        professional.photo,
                        fit: BoxFit.cover,
                      )
                          : Icon(Icons.person, size: 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        professional.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone: ${professional.phone}'),
                            Text('Place: ${professional.place}'),
                            Text('Score: ${professional.score}'),
                            Text('Bio: ${professional.bio}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Colors.black,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        tabBackgroundColor: Colors.grey.shade800,
        activeColor: Colors.white,
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.people_outline_rounded,
            text: 'Professionals',
          ),
          GButton(
            icon: Icons.history,
            text: 'History',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],

      ),
    );
  }
}
