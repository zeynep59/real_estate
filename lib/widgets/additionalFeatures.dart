import 'package:flutter/material.dart';

import '../theme/theme.dart';
class additionalFeaturesForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ek Özellikler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: additionalFeatures(),
    );
  }
}

class additionalFeatures extends StatefulWidget {
  @override
  _additionalFeaturesState createState() => _additionalFeaturesState();
}

class _additionalFeaturesState extends State<additionalFeatures> {
  List<String> facade = ['Kuzey', 'Güney', 'Doğu', 'Batı'];
  List<String> landscapeChoices = [
    'İstinat Duvarı',
    'Yan Bina',
    'Cadde/Sokak',
    'Bahçe',
    'Şehir',
    'Doğa',
    'Göl'
  ];
  List<String> heatingSystemChoices = [
    'Yok',
    'Soba',
    'Doğalgaz Sobası',
    'Kat Kaloriferi',
    'Doğalgaz/Kombi',
    'Merkezi Sistem',
    'Merkezi Isı Pay Ölçer',
    'Yerden Isıtma',
    'Klima Sistemi/Isı Pompası',
    'Jeotermal Isınma',
    'Güneş Enerjisi',
    'Diğer'
  ];

  List<String> selectedFacade = [];
  List<String> selectedLandscape = [];
  String selectedHeatingSystem = '';

  void toggleFacade(String cephe) {
    if (selectedFacade.contains(cephe)) {
      setState(() {
        selectedFacade.remove(cephe);
      });
    } else {
      setState(() {
        selectedFacade.add(cephe);
      });
    }
  }

  void toggleLandscape(String manzara) {
    if (selectedLandscape.contains(manzara)) {
      setState(() {
        selectedLandscape.remove(manzara);
      });
    } else {
      setState(() {
        selectedLandscape.add(manzara);
      });
    }
  }

  void selectHeatingSystem(String isitma) {
    setState(() {
      selectedHeatingSystem = isitma;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emlak Seçenekleri'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cephe Durumu:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: facade
                  .map((facadeName) => CheckboxListTile(
                title: Text(facadeName),
                value: selectedFacade.contains(facadeName),
                activeColor: Colors.blue,
                onChanged: (value) {
                  toggleFacade(facadeName);
                },
              ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Manzara:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: landscapeChoices
                  .map((landscapeName) => CheckboxListTile(
                title: Text(landscapeName),
                value: selectedLandscape.contains(landscapeName),
                activeColor: Colors.blue,
                onChanged: (value) {
                  toggleLandscape(landscapeName);
                },
              ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Isıtma Sistemi:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: heatingSystemChoices
                  .map((heating) => RadioListTile(
                title: Text(heating),
                value: heating,
                groupValue: selectedHeatingSystem,
                activeColor: lightColorScheme.primary,
                onChanged: (value) {
                  selectHeatingSystem(value!);
                },
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}