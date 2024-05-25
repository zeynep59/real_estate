import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart' as loc; // Use alias 'loc' for the 'location' package
import 'package:real_estate/screens/stepper_formPage.dart';
import 'package:real_estate/widgets/search_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:geocoding/geocoding.dart'; // Geocoding package for reverse geocoding
import 'package:real_estate/services/database_service.dart';
import 'package:real_estate/screens/settings.dart';
import '../components/searchField.dart';
import '../models/address.dart';
import '../models/house.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  loc.Location _locationController = loc.Location(); // Use alias 'loc' for the 'location' package
  late GoogleMapController _mapController;
  LatLng _currentLocation = const LatLng(37.4223, -122.0848);
  String _currentCity = "Loading...";

  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();

  TextStyle labelTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    fontFamily: 'Arial',
  );

  // Database Service instance
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method to get the current location and reverse geocode it
  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final loc.LocationData _locationData = await _locationController.getLocation();
    final LatLng currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    setState(() {
      _currentLocation = currentLatLng;
    });

    _reverseGeocodeLatLng(currentLatLng);
  }

  // Method to reverse geocode a LatLng position
  Future<void> _reverseGeocodeLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentCity = place.locality ?? 'Unknown';
          cityController.text = place.locality ?? '';
          countryController.text = place.country ?? '';
          districtController.text = place.subLocality ?? '';
          streetController.text = place.street ?? '';
        });
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 13),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 60.0,
        title: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFFFFE724C),
            ),
            Text(
              _currentCity,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 10,
            ), // Add some space between location and search field
            Expanded(
              child: SearchFieldWithSelection(), // Use the custom SearchFieldWithSelection widget
            ),
          ],
        ),
      ),
      body: SlidingUpPanel(
        panel: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFE724C),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: labelTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: labelTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: districtController,
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle: labelTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(
                  labelText: 'Street',
                  labelStyle: labelTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Form sayfasına git ve parametre gönder
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyStepper(),
                      settings: RouteSettings(
                        arguments: Address(
                          city: cityController.text,
                          country: countryController.text,
                          district: districtController.text,
                          street: streetController.text,
                          address: '${cityController.text}, ${countryController.text}, ${districtController.text}, ${streetController.text}',
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // Burada yuvarlaklık ayarlayabilirsiniz
                  ),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          onTap: (LatLng latLng) {
            _reverseGeocodeLatLng(latLng);
          },
          markers: {
            Marker(
              markerId: const MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _currentLocation,
            ),
          },
        ),
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: const Color(0xFF272D2F),
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        tabBackgroundColor: Colors.grey.shade800,
        activeColor: Colors.white,
        tabs: [
          const GButton(
            icon: Icons.home,
            text: "Home",
          ),
          const GButton(
            icon: Icons.search,
            text: "Search",
          ),
          const GButton(
            icon: Icons.favorite_border,
            text: "Favorites",
          ),
          const GButton(
            icon: Icons.settings,
            text: "Settings",
          ),
        ],
        onTabChange: (index) {
          if (index == 3) {
            Navigator.pushNamed(context, '/settings');
          }
        },
      ),
    );
  }
}
