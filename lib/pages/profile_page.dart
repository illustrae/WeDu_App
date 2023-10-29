import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
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

  String selectedService = 'Choose Service';

  Future<void> updateUserProfile(String username, String price, String experience, String selectedService) async {
    try(
      await FirebaseFirestore.instance.collection("Users").doc(UserCredential).update({

      })
    )
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
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 98, 158),
                      border:
                          Border.all(color: Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w100),
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //DROP DOWN BAR IN FORM>..
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedService,
                      onChanged: (String? newValue) {
                        // Update the selected value when the user makes a selection
                        setState(() {
                          selectedService = newValue!;
                        });
                      },
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 237, 230), // Text color
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w100,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down, // Dropdown icon
                        color: Color.fromARGB(255, 243, 237, 230), // Icon color
                      ),
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 13, 170, 167), // Item text color
                              fontSize: 18, // Item text font size
                              fontWeight:
                                  FontWeight.w400, // Item text font weight
                            ),
                          ),
                        );
                      }).toList(growable: false)),
                ),
//**************************************************************************//

                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 98, 158),
                      border:
                          Border.all(color: Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller:
                            _experienceController, // Create a TextEditingController for the experience field
                        decoration: InputDecoration(
                          labelText: 'Experience', // Label text for the field
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
                // DropdownButton<String>(
                //   value: selectedService,
                //   onChanged: (String? newValue) {
                //     // Update the selected value when the user makes a selection
                //     setState(() {
                //       selectedService = newValue!;
                //     });
                //   },
                //   items: items.map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(growable: false),
                // ),

                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 98, 158),
                      border:
                          Border.all(color: Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w100),
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 98, 158),
                      border:
                          Border.all(color: Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(255, 243, 237, 230),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w100),
                        controller: _bioController,
                        decoration: const InputDecoration(
                          labelText: 'Bio',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
