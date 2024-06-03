import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/professionel.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occurred: $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occurred: $e");
      return null;
    }
  }

  Future<void> updateProfile(String name, String phone) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await _firestore.collection('users').doc(user.uid).set({
          'phone': phone,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print("Error occurred during profile update: $e");
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>;
    }
    return {};
  }
  // Method to change user password
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email ?? '';

        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: oldPassword);
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);
      }
    } catch (e) {
      throw Exception("Error occurred during password change: $e");
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<Professional>> fetchProfessionals() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('pro').get();
      print('Fetched ${snapshot.docs.length} documents');
      if (snapshot.docs.isEmpty) {
        print('No documents found in "pro" collection');
      }
      return snapshot.docs
          .map((doc) {
        print('Document data: ${doc.data()}');
        return Professional.fromFirestore(doc.data() as Map<String, dynamic>);
      })
          .toList();
    } catch (e) {
      print('Error fetching professionals: $e');
      return [];
    }
  }
}
