import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
