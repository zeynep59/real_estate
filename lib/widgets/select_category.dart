import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Ensure this path is correct
import 'estate_features.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStepper(),
    );
  }
}

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5 Adımlı Stepper'),
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
        steps: List<Step>.generate(4, (index) {
          if (index == 1) { // This is the second step
            return Step(
              title: Text(''),
              content: EstateInformationForm(), // Use EstateInformationForm here
            );
          } else {
            return Step(
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
