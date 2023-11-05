import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileData extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController profileImageUrlController = TextEditingController();

  List<String> items = [
    'Planner',
    'Caterer',
    'Entertainer',
    'Photographer',
    'Transportation',
    'Venue Space',
    "Looking for Services.."
  ];

  String selectedService = 'Planner';

  CollectionReference profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<void> fetchUserProfile(String uid) async {
    try {
      final CollectionReference profiles =
          FirebaseFirestore.instance.collection('profiles');

      QuerySnapshot querySnapshot =
          await profiles.where('user_id', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Set your text controllers or variables with the retrieved data
        userNameController.text = data['username'] ?? '';
        priceController.text = data['price'] ?? '';
        bioController.text = data['bio'] ?? '';
        experienceController.text = data['experience'] ?? '';
        selectedService = data['service'] ?? 'Planner';
        profileImageUrlController.text = data['profileImageUrl'] ?? '';
      } else {
        userNameController.text = '';
        priceController.text = '';
        bioController.text = '';
        experienceController.text = '';
        selectedService = 'Planner';
        profileImageUrlController.text = '';

      }
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }
}
