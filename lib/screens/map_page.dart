import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/location.dart';
import 'package:real_estate/widgets/search_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:real_estate/components/searchField.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();
  static const LatLng _pApplePark = LatLng(37.4223, -122.0090);
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

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
            Icon(
              Icons.location_on,
              color: Color(0xFFFFE724C),
            ),
            const Text(
              "İzmir, Turkey",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(
                width: 10), // Add some space between location and search field
            Expanded(
              child:
                  SearchFieldWithSelection(), // Use the custom SearchFieldWithSelection widget
            ),
          ],
        ),
      ),
      body: SlidingUpPanel(
        panel: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFE724C),
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
            ],
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
          markers: {
            Marker(
              markerId: MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglePlex,
            ),
          },
        ),
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
      ),
    );
  }
}
