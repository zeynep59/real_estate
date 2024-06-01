import 'package:flutter/material.dart';
import 'package:real_estate/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/models/professionel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfessionelsScreen extends StatefulWidget {
@override
_ProfessionelsScreenState createState() => _ProfessionelsScreenState();
}

class _ProfessionelsScreenState extends State<ProfessionelsScreen> {
final FirebaseAuthService _authService = FirebaseAuthService();
late Future<List<Professional>> _professionalsFuture = Future.value([]);

@override
void initState() {
super.initState();
_authenticateAndFetchData();
}

Future<void> _authenticateAndFetchData() async {
print('Authenticating...');
var user = await _authService.signInWithEmailAndPassword('1@gmail.com', '123123');
if (user != null) {
print('User authenticated: ${user.email}');
setState(() {
_professionalsFuture = _authService.fetchProfessionals();
});
} else {
print('Authentication failed');
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Professionals'),
),
body: FutureBuilder<List<Professional>>(
future: _professionalsFuture,
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return Center(child: CircularProgressIndicator());
} else if (snapshot.hasError) {
return Center(child: Text('Error: ${snapshot.error}'));
} else if (!snapshot.hasData || snapshot.data!.isEmpty) {
return Center(child: Text('No data available'));
}

List<Professional> professionals = snapshot.data!;
return ListView.builder(
itemCount: professionals.length,
itemBuilder: (context, index) {
Professional professional = professionals[index];
return ListTile(
title: Text(professional.name),
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Phone: ${professional.phone}'),
Text('Place: ${professional.place}'),
Text('Score: ${professional.score}'),
Text('Bio: ${professional.bio}'),
],
),
leading: professional.photo.isNotEmpty
? Image.asset(professional.photo)
    : Icon(Icons.person),
);
},
);
},
),
);
}
}
