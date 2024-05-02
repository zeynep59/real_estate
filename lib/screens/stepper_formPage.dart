import 'package:flutter/material.dart';
import 'package:real_estate/widgets/additionalFeatures.dart';
import 'package:real_estate/widgets/opportunities.dart';
import '../theme/theme.dart';

class StepperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          canvasColor: Color(0xFFD7D7D7),
          colorScheme: Theme.of(context).colorScheme.copyWith(primary: lightColorScheme.primary ),
          //primaryColor: lightColorScheme.primary, // Stepper'ın başlık rengi
          textTheme: TextTheme(
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


  void initState() {
    super.initState();
    structureStatus = 'Well Maintained/Renovated';
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
          grossArea+=10;
          break;
        case 'Terrace Area':
          terraceArea+=10;
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
          if (grossArea > 0) grossArea--;
          break;
        case 'Terrace Area':
          if (terraceArea > 0) terraceArea--;
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
      backgroundColor:  Color(0xFFD7D7D7),
      appBar: AppBar(
        title: Text('5 Adımlı Stepper'),
        backgroundColor:  Color(0xFFD7D7D7),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,

        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() => _currentStep++);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: List<Step>.generate(5, (index) {
          if (index == 1) { // This is the second step
            return Step(
              isActive: true,
              state: _currentStep == 1 ? StepState.editing : StepState.indexed,
              title: Text(''),
              content:
              Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 50),
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 50),
                  child: TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: 'County',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 50),
                  child: TextFormField(
                    controller: districtController,
                    decoration: InputDecoration(
                      labelText: 'District',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 50),
                  child: TextFormField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: 'Street',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  constraints: BoxConstraints(maxHeight: 50),
                  child: TextFormField(
                    controller: squareMeterController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Squaremeter',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('State of Use:', style: TextStyle(fontSize: 16)),
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
                    Text('Property Owner'),
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
                    Text('Empty'),
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
                    Text('Tenant'),
                  ],
                ),

                SizedBox(height: 10),
                Text('Structure Status:', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Number of Rooms: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 49.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$countOfRoom',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Number of Rooms'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Number of Rooms'),
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
                        Text('Number of Halls: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 61.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$countOfSaloon',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Number of Halls'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Number of Halls'),
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
                        Text('Number of Bathrooms: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 22.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$countOfBath',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Number of Bathrooms'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Number of Bathrooms'),
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
                        Text('Gross Area: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 93.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$grossArea',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Gross Area'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Gross Area'),
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
                        Text('Terrace Area: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 82.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$terraceArea',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Terrace Area'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Terrace Area'),
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
                        Text('Building Age: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 82.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$buildingAge',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Building Age'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Building Age'),
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
                        Text('Floor on It is Located: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 27.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$whichFloor',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Floor on It is Located'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Floor on It is Located'),
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
                        Text('Number of Floors: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8.0), // Ekledim
                        Expanded(
                          child: Container(
                            height: 40.0, // Sabit yükseklik
                            margin: EdgeInsets.only(bottom: 8.0, left: 50.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFFE724C), width: 4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$countOfFloor',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0, // Yazı boyutunu ayarladım
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementValue('Number of Floors'),
                                      icon: Icon(Icons.remove),
                                    ),
                                    IconButton(
                                      onPressed: () => incrementValue('Number of Floors'),
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
            ],
              )
            );
          }
          else if (index == 2) { // This is the 5th step where you want to add the additionalFeatures widget
            return Step(
              isActive: true,
              state: _currentStep == 2 ? StepState.editing : StepState.indexed,
              title: Text(''),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Facade Selection',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      facade.length,
                          (int index) {
                        return FilterChip(
                          label: Text(facade[index]),
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
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Landscape Selection',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      landscapeChoices.length,
                          (int index) {
                        return FilterChip(
                          label: Text(landscapeChoices[index]),
                          selected: selectedLandscape.contains(landscapeChoices[index]),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedLandscape.add(landscapeChoices[index]);
                              } else {
                                selectedLandscape.remove(landscapeChoices[index]);
                              }
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Heating System Selection',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      heatingSystemChoices.length,
                          (int index) {
                        return FilterChip(
                          label: Text(heatingSystemChoices[index]),
                          selected: selectedHeatingSystem == heatingSystemChoices[index],
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedHeatingSystem = heatingSystemChoices[index];
                              } else {
                                selectedHeatingSystem = '';
                              }
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          }
          else if(index == 0){
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
          }
          else {
            return Step(
              isActive: true,
              state: _currentStep == 3 ? StepState.editing : StepState.indexed,
              title: Text(''),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Opportunities:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: oppurtunities
                          .map((oppurtunity) => CheckboxListTile(
                        title: Text(oppurtunity),
                        value: SelectedOppurtunities.contains(oppurtunity),
                        activeColor: lightColorScheme.primary,
                        onChanged: (value) {
                          toggleoppurtunity(oppurtunity);
                        },
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
