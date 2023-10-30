import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/pages/home_page.dart';


class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});
  

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  final List<String> items = [
    'Planner',
    'Caterer',
    'Entertainer',
    'Photographer',
    'Transportation',
    'Venue Space',
    "Looking for Services.."
  ];

  String selectedService = 'Planner';
@override
void initState(){
  super.initState();
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    print("User ID: ${user.uid}");
  }else{
    print("NOOOOOOO ID....");
  }
}

  CollectionReference profilesCollection = FirebaseFirestore.instance.collection('profiles');

  void _saveUserProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await profilesCollection.doc(user.email).set({
        'user_id': user.uid,
        'email': user.email,
        'username': _userNameController.text,
        'price': _priceController.text,
        'bio': _bioController.text,
        'experience': _experienceController.text,
        'service': selectedService,
      });
      
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage(initialHomePageIndex: 0)),
      
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 127, 57, 137),
              Color.fromARGB(255, 151, 98, 158),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 243, 237, 230),
                        child: Icon(
                          size: 70,
                          Icons.person,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 98, 158),
                      border: Border.all(color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: _userNameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedService,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedService = newValue!;
                      });
                    },
                    style: const TextStyle(
                      color: Color.fromARGB(255, 243, 237, 230),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w100,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 243, 237, 230),
                    ),
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 13, 170, 167),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(growable: false),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 98, 158),
                      border: Border.all(color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: _experienceController,
                        decoration: const InputDecoration(
                          labelText: 'Experience',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 98, 158),
                      border: Border.all(color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 98, 158),
                      border: Border.all(color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: _bioController,
                        decoration: const InputDecoration(
                          labelText: 'Bio',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveUserProfile,
                  child: const Text('Save Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
