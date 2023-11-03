import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ProfileData extends ChangeNotifier{
final user = FirebaseAuth.instance.currentUser;
   final TextEditingController userNameController = TextEditingController();
   final TextEditingController priceController = TextEditingController();
   final TextEditingController bioController = TextEditingController();
   final TextEditingController experienceController = TextEditingController();

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

  CollectionReference profilesCollection = FirebaseFirestore.instance.collection('profiles');


 Future<void> fetchUserProfile(String uid) async {
    try {
      if (user != null) {
        final userId = user?.uid;
        final profileDoc = await profilesCollection.doc(userId).get();

        if (profileDoc.exists) {
          final data = profileDoc.data() as Map<String, dynamic>;
          userNameController.text = data['username'] ?? '';
          priceController.text = data['price'] ?? '';
          bioController.text = data['bio'] ?? '';
          experienceController.text = data['experience'] ?? '';
          selectedService = data['service'] ?? 'Planner';
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    notifyListeners(); // Notify listeners of the changes
  }


}
