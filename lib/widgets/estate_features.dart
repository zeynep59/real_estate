import 'package:flutter/material.dart';

import '../theme/theme.dart';

class EstateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ev Bilgi Formu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EstateInformationForm(),
    );
  }
}

class EstateInformationForm extends StatefulWidget {
  @override
  State<EstateInformationForm> createState() => _EstateInformationFormState();
}

class _EstateInformationFormState extends State<EstateInformationForm> {
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final squareMeterController = TextEditingController();
  String? typeOfHeating = "Doğalgaz";
  String? stateOfUse = "Mülk Sahibi"; // Varsayılan değer
  String? structureStatus = "Bakımlı/Yenilenmiş"; // Varsayılan değer
  int countOfRoom = 1;
  int countOfSaloon = 1;
  int countOfBath = 1;
  int grossArea = 0;
  int terraceArea = 0;
  int buildingAge = 0;
  int whichFloor = 0;
  int countOfFloor = 0;
  @override
  void dispose() {
    cityController.dispose();
    countryController.dispose();
    districtController.dispose();
    streetController.dispose();
    squareMeterController.dispose();
    super.dispose();
  }
  void incrementValue(String field) {
    setState(() {
      switch (field) {
        case 'OdaSayisi':
          countOfRoom++;
          break;
        case 'SalonSayisi':
          countOfSaloon++;
          break;
        case 'DusAlinanBanyoSayisi':
          countOfBath++;
          break;
        case 'BrutAlan':
          grossArea++;
          break;
        case 'TerasAlani':
          terraceArea++;
          break;
        case 'BinaYasi':
          buildingAge++;
          break;
        case 'BulunduguKat':
          whichFloor++;
          break;
        case 'BinaKatSayisi':
          countOfFloor++;
          break;
      }
    });
  }

  void decrementValue(String field) {
    setState(() {
      switch (field) {
        case 'OdaSayisi':
          if (countOfRoom > 1) countOfRoom--;
          break;
        case 'SalonSayisi':
          if (countOfSaloon > 1) countOfSaloon--;
          break;
        case 'DusAlinanBanyoSayisi':
          if (countOfBath > 1) countOfBath--;
          break;
        case 'BrutAlan':
          if (grossArea > 0) grossArea--;
          break;
        case 'TerasAlani':
          if (terraceArea > 0) terraceArea--;
          break;
        case 'BinaYasi':
          if (buildingAge > 0) buildingAge--;
          break;
        case 'BulunduguKat':
          if (whichFloor > 0) whichFloor--;
          break;
        case 'BinaKatSayisi':
          if (countOfFloor > 0) countOfFloor--;
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ev Bilgi Formu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'İl'),
              ),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'İlçe'),
              ),
              TextFormField(
                controller: districtController,
                decoration: InputDecoration(labelText: 'Mahalle'),
              ),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Sokak'),
              ),
              TextFormField(
                controller: squareMeterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Metrekare'),
              ),
              DropdownButtonFormField(
                value: typeOfHeating,
                onChanged: (value) {
                  setState(() {
                    typeOfHeating = value;
                  });
                },
                items: <String>[
                  'Doğalgaz',
                  'Merkezi Isıtma',
                  'Kombi',
                  'Kalorifer',
                  'Soba'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text('Kullanım Durumu:', style: TextStyle(fontSize: 16)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Mülk Sahibi',
                        groupValue: stateOfUse,
                        onChanged: (value) {
                          setState(() {
                            stateOfUse = value!;
                          });
                        },
                      ),
                      Text('Mülk Sahibi'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Boş',
                        groupValue: stateOfUse,
                        onChanged: (value) {
                          setState(() {
                            stateOfUse = value!;
                          });
                        },
                      ),
                      Text('Boş'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Kiracı',
                        groupValue: stateOfUse,
                        onChanged: (value) {
                          setState(() {
                            stateOfUse = value!;
                          });
                        },
                      ),
                      Text('Kiracı'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Oda Sayısı: $countOfRoom'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('OdaSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('OdaSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Salon Sayısı: $countOfSaloon'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('SalonSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('SalonSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Duş Alınan Banyo Sayısı: $countOfBath'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('DusAlinanBanyoSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('DusAlinanBanyoSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Brüt Alan (m²): $grossArea'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BrutAlan'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BrutAlan'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Teras Alanı (m²): $terraceArea'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('TerasAlani'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('TerasAlani'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bina Yaşı: $buildingAge'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BinaYasi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BinaYasi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bulunduğu Kat: $whichFloor'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BulunduguKat'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BulunduguKat'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bina Kat Sayısı: $countOfFloor'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BinaKatSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BinaKatSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                ],
              ),
              SizedBox(height: 10),
              Text('Yapı Durumu:', style: TextStyle(fontSize: 16)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Bakımlı/Yenilenmiş',
                        groupValue: structureStatus,
                        onChanged: (value) {
                          setState(() {
                            structureStatus = value!;
                          });
                        },
                      ),
                      Text('Bakımlı/Yenilenmiş'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Standart',
                        groupValue: structureStatus,
                        onChanged: (value) {
                          setState(() {
                            structureStatus = value!;
                          });
                        },
                      ),
                      Text('Standart'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Tadilat İhtiyacı Var',
                        groupValue: structureStatus,
                        onChanged: (value) {
                          setState(() {
                            structureStatus = value!;
                          });
                        },
                      ),
                      Text('Tadilat İhtiyacı Var'),
                    ],
                  ),SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Oda Sayısı: $countOfRoom'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('OdaSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('OdaSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Salon Sayısı: $countOfSaloon'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('SalonSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('SalonSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Duş Alınan Banyo Sayısı: $countOfBath'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('DusAlinanBanyoSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('DusAlinanBanyoSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Brüt Alan (m²): $grossArea'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BrutAlan'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BrutAlan'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Teras Alanı (m²): $terraceArea'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('TerasAlani'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('TerasAlani'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bina Yaşı: $buildingAge'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BinaYasi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BinaYasi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bulunduğu Kat: $whichFloor'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BulunduguKat'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BulunduguKat'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bina Kat Sayısı: $countOfFloor'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => decrementValue('BinaKatSayisi'),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => incrementValue('BinaKatSayisi'),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),

            ],
          ),
        ],
      ),

    ],
    ),
    ),
      ),
    );
  }
}
