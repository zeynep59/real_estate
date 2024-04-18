import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _currentStep = 0;

  final List<String> _titles = [
    'Select Real Estate Type',
    'Enter Property Details',
    'Add Photos',
    'Review & Submit',
    'Confirmation',
  ];

  final List<String> _descriptions = [
    'Choose a real estate type to proceed',
    'Enter the property details carefully',
    'Add at least 2 high-quality photos of your property',
    'Review & submit the form to list your property',
    'Congratulations! Your property is live on our platform',
  ];

  final List<StepData> _steps = [
    StepData(
      img: 'house.png',
      title: 'House',
      onTap: () {
        setState(() {
          _currentStep = 1;
        });
      },
    ),
    StepData(
      img: 'apartment.png',
      title: 'Apartment',
      onTap: () {
        setState(() {
          _currentStep = 1;
        });
      },
    ),
    StepData(
      img: 'condo.png',
      title: 'Condo',
      onTap: () {
        setState(() {
          _currentStep = 1;
        });
      },
    ),
    StepData(
      img: 'land.png',
      title: 'Land',
      onTap: () {
        setState(() {
          _currentStep = 1;
        });
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_titles[_currentStep]),
                Text(_descriptions[_currentStep]),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _steps.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: _steps[index].onTap,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/${_steps[index].img}',
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          _steps[index].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: index == _currentStep ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: index == _currentStep ? null : () {
                            setState(() {
                              _currentStep = index;
                            });
                          },
                          child: Text('SELECT'),
                          style: ElevatedButton.styleFrom(
                            primary: index == _currentStep ? Colors.grey[400] : Colors.blue,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Color(0xFF272D2F

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
