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

}