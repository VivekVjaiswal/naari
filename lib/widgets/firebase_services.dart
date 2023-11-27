

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_profile.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile> fetchUserProfile(User user) async {
    try {
      // Use the user.uid as the document ID
      var doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        return UserProfile.fromMap(doc.data()!);
      } else {
        throw Exception('User profile not found');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  Future<void> saveUserProfile(User user, UserProfile userProfile) async {
    try {
      // Use the user.uid as the document ID
      await _firestore.collection('users').doc(user.uid).set(userProfile.toMap());
    } catch (e) {
      throw Exception('Error saving user profile: $e');
    }
  }
}
