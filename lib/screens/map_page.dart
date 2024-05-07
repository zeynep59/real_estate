import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart';
import 'package:real_estate/screens/home_screen.dart';
import 'package:real_estate/screens/stepper_formPage.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();
  static const LatLng _pApplePark = LatLng(37.4223, -122.0090);
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  LatLng? _currentP = null;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MapPage(),
    HomeScreen(),
    MyStepper(),
  ];

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _currentP!, zoom: 13),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
              },
            ),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Color(0xFF272D2F),
        color: Colors.white,
        padding: EdgeInsets.all(16),
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
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToScreen(index);
        },
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    // Code for getting location updates
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/map_page');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/form_page');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/home_page');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/sign_up');
        break;
      default:
        break;
    }
  }
}
