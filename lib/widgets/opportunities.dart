import 'package:flutter/material.dart';

import '../theme/theme.dart';

class Oppurtunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olanaklar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OppurtunitiesPage(),
    );
  }
}

class OppurtunitiesPage extends StatefulWidget {
  @override
  _OppurtunitiesPageState createState() => _OppurtunitiesPageState();
}

class _OppurtunitiesPageState extends State<OppurtunitiesPage> {
  List<String> oppurtunities = [
    'Anayol Üzeri',
    'Cadde Üzeri',
    'Spor Sahası/Salonu',
    'Çocuk Oyun Parkı',
    'Asansör',
    'Jeneratör',
    'Bina/Site Görevlisi',
    'Güvenlik',
    'Otopark',
    'Kapalı Otopark',
    'Açık Havuz',
    'Kapalı Havuz',
    'Isı Yalıtımı',
    'Klima',
    'Şömine',
  ];

  List<String> SelectedOppurtunities = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olanaklar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Olanaklar:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: oppurtunities
                  .map((oppurtunity) => CheckboxListTile(
                title: Text(oppurtunity),
                value: SelectedOppurtunities.contains(oppurtunity),
                activeColor: lightColorScheme.primary, // Seçildiğinde mavi renk
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
}
