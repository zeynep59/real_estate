import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:real_estate/services/database_service.dart';
import '../models/house.dart';

class FavoritesPanel extends StatefulWidget {
  @override
  _FavoritesPanelState createState() => _FavoritesPanelState();
}

class _FavoritesPanelState extends State<FavoritesPanel> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: StreamBuilder<QuerySnapshot<House>>(
        stream: _databaseService.getHousesByUserId(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<House> houses =
                snapshot.data!.docs.map((doc) => doc.data()).toList();

            return ListView.builder(
              itemCount: houses.length,
              itemBuilder: (context, index) {
                House house = houses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      // Actions when the button is pressed
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.home),
                              SizedBox(width: 8),
                              Text('Price: ${house.price}'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text('Location: ${house.address.city}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
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
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/map_page');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/professionels');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/history');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          }
        },
      ),
    );
  }
}
