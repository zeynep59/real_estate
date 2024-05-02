import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AdSoyadAlani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFD7D7D7), // Arka plan rengi
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
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
            ),
          ),
        ],
      ),
    );
  }
  Widget categoryButton(IconData icon, String text) {
    return SizedBox(
      width: 100, // İstediğiniz genişlik
      height: 100, // İstediğiniz yükseklik
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
                  color: Colors.black, // Metin rengi koyu
                  fontWeight: FontWeight.bold, // Kalın font
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

