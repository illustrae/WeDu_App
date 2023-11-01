import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/pages/profile_view.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileData profileData = Provider.of<ProfileData>(context);

  @override
  void initState() {
    super.initState();
  }

  void _saveUserProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await profileData.profilesCollection.doc(user.email).set({
        'user_id': user.uid,
        'email': user.email,
        'username': profileData.userNameController.text,
        'price': profileData.priceController.text,
        'bio': profileData.bioController.text,
        'experience': profileData.experienceController.text,
        'service': profileData.selectedService,
      });

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ProfileView()),
      );
    }
  }

  bool isEditable = false;

  void editProfile() {
    setState(() {
      isEditable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileData(),
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 243, 237, 230),
                        child: Icon(
                          size: 80,
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
                      color: isEditable
                          ? const Color.fromARGB(255, 151, 98, 158)
                          : Colors.grey,
                      border: Border.all(
                          color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        enabled: isEditable,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: profileData.userNameController,
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
                    value: profileData.selectedService,
                    onChanged: (String? newValue) {
                      setState(() {
                        profileData.selectedService = newValue!;
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
                    items: profileData.items
                        .map<DropdownMenuItem<String>>((String value) {
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
                      border: Border.all(
                          color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        enabled: isEditable,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: profileData.experienceController,
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
                      border: Border.all(
                          color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        enabled: isEditable,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: profileData.priceController,
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
                      border: Border.all(
                          color: const Color.fromARGB(255, 13, 170, 167)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        enabled: isEditable,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 237, 230),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w100,
                        ),
                        controller: profileData.bioController,
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
                  onPressed: editProfile,
                  child: Text('Edit Profile'),
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
