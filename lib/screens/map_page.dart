import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart' as loc;
import 'package:real_estate/screens/stepper_formPage.dart';
import 'package:real_estate/widgets/search_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:real_estate/screens/professionels.dart';
import 'package:geocoding/geocoding.dart';
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
  loc.Location _locationController = loc.Location();
  late GoogleMapController _mapController;
  LatLng _currentLocation = const LatLng(41.0082, 28.9784); // Istanbul's coordinates
  String _currentCity = "Loading...";
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool _showFavorites = false;

  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final searchController = TextEditingController(); // Controller for the search field

  TextStyle labelTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    fontFamily: 'Arial',
  );

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print('Current User UID: ${currentUser.uid}');
    } else {
      print('No user logged in.');
    }
  }

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

  Future<void> _reverseGeocodeLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentCity = place.administrativeArea ?? 'Unknown';
          cityController.text = place.administrativeArea ?? '';
          countryController.text = place.country ?? '';
          districtController.text = place.subAdministrativeArea ?? '';
          streetController.text = place.name ?? '';
        });
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 13),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _searchAndNavigate() async {
    try {
      List<Location> locations = await locationFromAddress(searchController.text);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng target = LatLng(location.latitude, location.longitude);
        setState(() {
          _currentLocation = target;
        });
        _mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 13));
        _reverseGeocodeLatLng(target);
      }
    } catch (e) {
      print('Error occurred while searching: $e');
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
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchAndNavigate,
                  ),
                ),
                onSubmitted: (value) {
                  _searchAndNavigate();
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 13),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: (LatLng latLng) {
              setState(() {
                _currentLocation = latLng;
              });
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
          SlidingUpPanel(
            panel: _showFavorites ? _buildFavoritesPanel() : _buildAddressPanel(),
            onPanelClosed: () {
              setState(() {
                _showFavorites = false;
              });
            },
          ),
        ],
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
        onTabChange: (index) {
          setState(() {
            if (index == 0) {
              _showFavorites = false;
            } else if (index == 1) {
              Navigator.pushNamed(context, '/professionels');
            } else if (index == 2) {
              _showFavorites = true;
            } else if (index == 3) {
              Navigator.pushNamed(context, '/settings');
            }
          });
        },
      ),
    );
  }

  Widget _buildFavoritesPanel() {
    return StreamBuilder<QuerySnapshot<House>>(
      stream: _databaseService.getHousesByUserId(currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<House> houses = snapshot.data!.docs.map((doc) => doc.data()).toList();
          return ListView.builder(
            itemCount: houses.length,
            itemBuilder: (context, index) {
              House house = houses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: OutlinedButton(
                  onPressed: () {},
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
    );
  }

  Widget _buildAddressPanel() {
    return Container(
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
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
