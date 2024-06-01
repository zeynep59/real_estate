import 'package:flutter/material.dart';
import 'package:real_estate/models/address.dart';
import '../models/house.dart';
import '../theme/theme.dart';
import 'package:real_estate/services/database_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StepperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(primary: lightColorScheme.primary),
          //primaryColor: lightColorScheme.primary, // Stepper'ın başlık rengi
          textTheme: const TextTheme(
              //subtitle1: TextStyle(color: lightColorScheme.primary), // Adım numaralarının rengi
              //bodyText2: TextStyle(color: lightColorScheme.primary), // Adım başlıklarının rengi
              ),
        ),
        child: MyStepper(),
      ),
    );
  }
}

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final squareMeterController = TextEditingController();
  String? typeOfHeating = "Natural Gas/Combi";
  String? stateOfUse = "Property Owner"; // Default value
  late String? structureStatus; // Default value
  int countOfRoom = 1;
  int countOfSaloon = 1;
  int countOfBath = 1;
  int grossArea = 0;
  int terraceArea = 0;
  int buildingAge = 0;
  int whichFloor = 0;
  int countOfFloor = 0;
  List<String> facade = ['North', 'South', 'East', 'West'];
  List<String> landscapeChoices = [
    'Retaining Wall',
    'Side Building',
    'Street/Street',
    'Garden',
    'City',
    'Nature',
    'The Lake'
  ];
  List<String> heatingSystemChoices = [
    'No',
    'Stove',
    'Natural Gas Stove',
    'Floor Heating',
    'Natural Gas/Combi',
    'Centralised System',
    'Central Heat Share Meter',
    'Underfloor Heating',
    'Air Conditioning System/Heat Pump',
    'Geothermal Heating',
    'Solar Energy',
    'Other'
  ];

  List<String> selectedFacade = [];
  List<String> selectedLandscape = [];
  String selectedHeatingSystem = '';
  bool valueAndRent = false;
  int value1 = 1780;
  double predictedPrice = 0.0;
  int value2 = 1980;
  List<String> oppurtunities = [
    'On the motorway',
    'On the Street',
    'Sports Field/Salon',
    'Children\'s Playground',
    'The lift',
    'Generator',
    'Building/Site Caretaker',
    'Security',
    'Car park',
    'Parking Garage',
    'Open Pool',
    'Indoor pool',
    'Thermal Insulation',
    'Air conditioning',
    'Fireplace',
  ];

  List<String> SelectedOppurtunities = [];
  final DatabaseService _databaseService = DatabaseService();

  late Address address;

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      address = ModalRoute.of(context)!.settings.arguments as Address;
      predictedPrice = predictedPrice;
      setState(() {
        structureStatus = 'Well Maintained/Renovated';
      });
    });
  }

  void toggleoppurtunity(String oppurtunity) {
    if (SelectedOppurtunities.contains(oppurtunity)) {
      setState(() {
        SelectedOppurtunities.remove(oppurtunity);
      });
    } else {
      setState(() {
        SelectedOppurtunities.add(oppurtunity);
      });
    }
  }

  void incrementValue(String field) {
    setState(() {
      switch (field) {
        case 'Number of Rooms':
          countOfRoom++;
          break;
        case 'Number of Halls':
          countOfSaloon++;
          break;
        case 'Number of Bathrooms':
          countOfBath++;
          break;
        case 'Gross Area':
          grossArea += 10;
          break;
        case 'Terrace Area':
          terraceArea += 10;
          break;
        case 'Building Age':
          buildingAge++;
          break;
        case 'Floor on Which It is Located':
          whichFloor++;
          break;
        case 'Number of Floors':
          countOfFloor++;
          break;
      }
    });
  }

  void decrementValue(String field) {
    setState(() {
      switch (field) {
        case 'Number of Rooms':
          if (countOfRoom > 1) countOfRoom--;
          break;
        case 'Number of Halls':
          if (countOfSaloon > 1) countOfSaloon--;
          break;
        case 'Number of Bathrooms':
          if (countOfBath > 1) countOfBath--;
          break;
        case 'Gross Area':
          if (grossArea > 0) grossArea -= 10;
          break;
        case 'Terrace Area':
          if (terraceArea > 0) terraceArea -= 10;
          break;
        case 'Building Age':
          if (buildingAge > 0) buildingAge--;
          break;
        case 'Floor on Which It is Located':
          if (whichFloor > 0) whichFloor--;
          break;
        case 'Number of Floors':
          if (countOfFloor > 0) countOfFloor--;
          break;
      }
    });
  }

  void toggleFacade(String facade) {
    if (selectedFacade.contains(facade)) {
      setState(() {
        selectedFacade.remove(facade);
      });
    } else {
      setState(() {
        selectedFacade.add(facade);
      });
    }
  }

  void toggleLandscape(String landscape) {
    if (selectedLandscape.contains(landscape)) {
      setState(() {
        selectedLandscape.remove(landscape);
      });
    } else {
      setState(() {
        selectedLandscape.add(landscape);
      });
    }
  }

  void selectHeatingSystem(String heating) {
    setState(() {
      selectedHeatingSystem = heating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () async {
          if (_currentStep < 3) {
            setState(() => _currentStep++);
          } else if (_currentStep == 3) {
            House house = House(
              address: address,
              squaremeter: double.parse(squareMeterController.text),
              numberOfRooms: countOfRoom,
              numberOfHalls: countOfSaloon,
              numberOfBaths: countOfBath,
              buildingAge: buildingAge,
              numberOfFloors: countOfFloor,
              floorOn: whichFloor,
              grossArea: grossArea.toDouble(),
              terraceArea: terraceArea.toDouble(),
              facade: selectedFacade,
              landscape: selectedLandscape,
              price: 0,
              opportunities: SelectedOppurtunities,
              heating: selectedHeatingSystem,
            );
            //add given house to the firestore db
            _databaseService.addHouse(house);

            String jsonData = jsonEncode(house.toJson());
            // Send JSON data to Flask API
            try {
              var response = await http.post(
                Uri.parse("http://10.0.2.2:5000/predict"),
                body: jsonData,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              );

              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              if (response.statusCode == 200) {
                print('House data sent successfully');
                var jsonResponse = jsonDecode(response.body);
                predictedPrice = jsonResponse['predictedPrice'];
              } else {
                print('Failed to send house data: ${response.statusCode}');
              }
            } catch (e) {
              print('Error: $e');
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else if (_currentStep == 0) {
            Navigator.pop(context);
          }
        },
        steps: List<Step>.generate(4, (index) {
          if (index == 0) {
            // This is the second step
            TextStyle labelTextStyle = const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontFamily: 'Arial',
            );

            return Step(
              isActive: true,
              state: _currentStep == 0 ? StepState.editing : StepState.indexed,
              title: Text(''),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  const Text(
                    'Size:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFE724C),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10), // Adding space between the text and container
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFFE724C), width: 1.0),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    constraints: BoxConstraints(maxHeight: 50),
                    child: TextFormField(
                      controller: squareMeterController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Squaremeter',
                        labelStyle: labelTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'State of Use:',
                    style: labelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(
                          0xFFFE724C), // Yeni renk burada belirtiliyor
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Property Owner',
                            groupValue: stateOfUse,
                            onChanged: (value) {
                              setState(() {
                                stateOfUse = value!;
                              });
                            },
                          ),
                          Text(
                            'Property Owner',
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Empty',
                            groupValue: stateOfUse,
                            onChanged: (value) {
                              setState(() {
                                stateOfUse = value!;
                              });
                            },
                          ),
                          Text(
                            'Empty',
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Tenant',
                            groupValue: stateOfUse,
                            onChanged: (value) {
                              setState(() {
                                stateOfUse = value!;
                              });
                            },
                          ),
                          Text(
                            'Tenant',
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Structure Status:',
                    style: labelTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFE724C),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Number of Rooms: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 52.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$countOfRoom',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Number of Rooms'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Number of Rooms'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of Halls: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 66.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$countOfSaloon',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Number of Halls'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Number of Halls'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of Bathrooms: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 22.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$countOfBath',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => decrementValue(
                                            'Number of Bathrooms'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () => incrementValue(
                                            'Number of Bathrooms'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Gross Area: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 104.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$grossArea',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Gross Area'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Gross Area'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Terrace Area: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 92.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$terraceArea',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Terrace Area'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Terrace Area'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Building Age: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 93.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$buildingAge',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Building Age'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Building Age'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Floor on It is Located: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 30.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$whichFloor',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => decrementValue(
                                            'Floor on Which It is Located'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () => incrementValue(
                                            'Floor on Which It is Located'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Number of Floors: ',
                            style: labelTextStyle,
                          ),
                          SizedBox(width: 8.0), // Ekledim
                          Expanded(
                            child: Container(
                              height: 40.0, // Sabit yükseklik
                              margin: EdgeInsets.only(bottom: 8.0, left: 57.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFFFE724C), width: 1.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '$countOfFloor',
                                        textAlign: TextAlign.center,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decrementValue('Number of Floors'),
                                        icon: Icon(Icons.remove),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            incrementValue('Number of Floors'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (index == 1) {
            // This is the 5th step where you want to add the additionalFeatures widget
            return Step(
              isActive: true,
              state: _currentStep == 1 ? StepState.editing : StepState.indexed,
              title: Text(''),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Facade Selection',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFE724C)),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      facade.length,
                      (int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilterChip(
                            label: Text(facade[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                            selected: selectedFacade.contains(facade[index]),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedFacade.add(facade[index]);
                                } else {
                                  selectedFacade.remove(facade[index]);
                                }
                              });
                            },
                            // Çerçeve rengini değiştirmek için Material widget'ını kullanın
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: selectedFacade.contains(facade[index])
                                    ? lightColorScheme
                                        .primary // Seçili olduğunda çerçeve rengi
                                    : Colors
                                        .black, // Seçili olmadığında çerçeve rengi
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Landscape Selection',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFE724C)),
                  ),
                  Wrap(
                    spacing: 5.0, // Seçenekler arasındaki yatay boşluk
                    runSpacing: 3.0, // Seçenekler arasındaki dikey boşluk
                    children: List<Widget>.generate(
                      landscapeChoices.length,
                      (int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilterChip(
                            label: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(landscapeChoices[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            selected: selectedLandscape
                                .contains(landscapeChoices[index]),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedLandscape
                                      .add(landscapeChoices[index]);
                                } else {
                                  selectedLandscape
                                      .remove(landscapeChoices[index]);
                                }
                              });
                            },
                            backgroundColor: Colors.transparent,
                            checkmarkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: selectedLandscape
                                        .contains(landscapeChoices[index])
                                    ? lightColorScheme
                                        .primary // Seçili olduğunda çerçeve rengi
                                    : Colors
                                        .black, // Seçili olmadığında çerçeve rengi
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Heating System Selection',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFE724C)),
                  ),
                  Wrap(
                    spacing: 5.0, // Seçenekler arasındaki yatay boşluk
                    runSpacing: 3.0, // Seçenekler arasındaki dikey boşluk
                    children: List<Widget>.generate(
                      heatingSystemChoices.length,
                      (int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilterChip(
                            label: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(heatingSystemChoices[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            selected: selectedHeatingSystem ==
                                heatingSystemChoices[index],
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedHeatingSystem =
                                      heatingSystemChoices[index];
                                } else {
                                  selectedHeatingSystem = '';
                                }
                              });
                            },
                            backgroundColor: Colors.transparent,
                            checkmarkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: selectedHeatingSystem ==
                                        heatingSystemChoices[index]
                                    ? lightColorScheme
                                        .primary // Seçili olduğunda çerçeve rengi
                                    : Colors
                                        .black, // Seçili olmadığında çerçeve rengi
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          } else if (index == 3) {
            return Step(
              isActive: true,
              state: _currentStep == 3 ? StepState.editing : StepState.indexed,
              title: const Text(''),
              /*content: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"), // Arka plan fotoğrafı
                      fit: BoxFit.cover,
                    ),
                  ),*/
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Bir boşluk ekleyin
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Value',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE724C)),
                        ),
                        Transform.scale(
                          scale:
                              0.9, // Boyut oranı, istediğiniz değeri ayarlayabilirsiniz
                          child: Switch(
                            value: valueAndRent,
                            onChanged: (bool value) {
                              setState(() {
                                valueAndRent = value;
                                // Switch değiştiğinde değerlerin güncellenmesi
                                if (valueAndRent) {
                                  value1 = 2000;
                                  value2 = 3000;
                                } else {
                                  value1 = 1780;
                                  value2 = 1980;
                                }
                              });
                            },
                            activeColor: lightColorScheme.primary,
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // Switch boyutunu sadece buton büyüklüğü kadar yapar
                          ),
                        ),
                        const Text(
                          'Rent',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE724C)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Bir boşluk ekleyin
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red, // İstediğiniz renk
                        size: 24, // İstediğiniz boyut
                      ),
                      SizedBox(width: 10), // Araya bir boşluk ekleyin
                      Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFE724C)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Bir boşluk ekleyin
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                                width: 5), // Araya bir boşluk ekleyin
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${predictedPrice.toStringAsFixed(2)}₺', // Show predictedPrice instead of price1
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                                width: 5), // Araya bir boşluk ekleyin
                            const Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                                width: 5), // Araya bir boşluk ekleyin
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${value2}₺',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                                width: 5), // Araya bir boşluk ekleyin
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '0-3 months predicted',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' Disposal time',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width: 5), // Araya bir boşluk ekleyin
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '6-12 months predicted',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' Disposal time',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Bir boşluk ekleyin
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 300,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC529),
                                border: Border.all(
                                    color: Color(0xFFD7D7D7).withOpacity(1)),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: const Column(
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'First Box Text 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'First Box Text 2',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'First Box Text 3',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height: 20), // Araya bir boşluk ekleyin
                            Container(
                              height: 150,
                              width: 300,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC529),
                                border: Border.all(
                                    color: Color(0xFFD7D7D7).withOpacity(1)),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: const Column(
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Second Box Text 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Second Box Text 2',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height: 20), // Araya bir boşluk ekleyin
                            Container(
                              width: 300,
                              height: 150,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFE724C),
                                border: Border.all(
                                    color: Color(0xFFD7D7D7).withOpacity(1)),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Third Box Text 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  const Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: '_ _ _',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //),
            );
          }
          /*else if (index == 0) {
            return Step(
              isActive: true,
              title: Text(''),
              content: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2,
                children: [
                  categoryButton(Icons.house_rounded, "Houses"),
                  categoryButton(Icons.villa_rounded, "Villa"),
                  categoryButton(Icons.apartment_rounded, "Apartment"),
                  categoryButton(Icons.castle_rounded, "Castles"),
                ],
              ),
            );
          }*/
          else {
            return Step(
              isActive: true,
              state: _currentStep == 2 ? StepState.editing : StepState.indexed,
              title: const Text(''),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Opportunities:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFE724C),
                            fontSize: 18),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: oppurtunities
                          .map((oppurtunity) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0), // Boşluk eklendi
                                child: CheckboxListTile(
                                  title: Text(oppurtunity,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400)),
                                  value: SelectedOppurtunities.contains(
                                      oppurtunity),
                                  activeColor: lightColorScheme.primary,
                                  onChanged: (value) {
                                    toggleoppurtunity(oppurtunity);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget categoryButton(IconData icon, String text) {
    return SizedBox(
      width: 100, // Desired width
      height: 100, // Desired height
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: lightColorScheme.primary, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 42,
                color: lightColorScheme.primary,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black, // Text color dark
                  fontWeight: FontWeight.bold, // Bold font
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EstateInformationForm extends StatelessWidget {
  final TextEditingController cityController;
  final TextEditingController countryController;
  final TextEditingController districtController;
  final TextEditingController streetController;
  final TextEditingController squareMeterController;
  final String? typeOfHeating;
  final String? stateOfUse;
  final String? structureStatus;
  final int countOfRoom;
  final int countOfSaloon;
  final int countOfBath;
  final int grossArea;
  final int terraceArea;
  final int buildingAge;
  final int whichFloor;
  final int countOfFloor;

  List<String> selectedFacade = [];
  List<String> selectedLandscape = [];
  String selectedHeatingSystem = '';
  final Function(String) incrementValue;
  final Function(String) decrementValue;

  EstateInformationForm({
    required this.cityController,
    required this.countryController,
    required this.districtController,
    required this.streetController,
    required this.squareMeterController,
    required this.typeOfHeating,
    required this.stateOfUse,
    required this.structureStatus,
    required this.countOfRoom,
    required this.countOfSaloon,
    required this.countOfBath,
    required this.grossArea,
    required this.terraceArea,
    required this.buildingAge,
    required this.whichFloor,
    required this.countOfFloor,
    required this.incrementValue,
    required this.decrementValue,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
