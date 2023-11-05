import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/pages/profile_view.dart';
import 'package:login_reg/storage/imageupload.dart';
import 'package:login_reg/themes/profile_theme.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileData profileData = Provider.of<ProfileData>(context);
  final ImageUploads imageUploads = ImageUploads(); 

  void _saveUserProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await profileData.profilesCollection.doc(user.email).update({
        'user_id': user.uid,
        'email': user.email,
        'username': profileData.userNameController.text,
        'price': profileData.priceController.text,
        'bio': profileData.bioController.text,
        'experience': profileData.experienceController.text,
        'service': profileData.selectedService,
        'profileImageUrl': profileData.profileImageUrlController.text,
      });

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const ProfileView(
                  key: Key('profile_view_key'),
                )),
      );
    }
  }

  bool isEditable = false;
  bool showSpinner = false;

  void toggleSpinner() {
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  void editProfile() {
    print("Before editing: isEditable = $isEditable");
    setState(() {
      isEditable = true;
    });
    print("After editing: isEditable = $isEditable");
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemes.profileTheme(isEditable),
      child: ChangeNotifierProvider(
        create: (context) => ProfileData(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 3,
              shadowColor: Colors.black,
              centerTitle: true,
              title: const Text("WeDU"),
              titleTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 13, 170, 167),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
              backgroundColor: const Color.fromARGB(255, 127, 57, 137),
            ),
            extendBody: true,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              dismissible: showSpinner,
              child: Container(
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
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    height: 800,
                    child: Column(
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: imageUploads,
                              // child: CircleAvatar(
                              //   radius: 60,
                              //   backgroundColor:
                              //       Color.fromARGB(255, 243, 237, 230),
                              //   child: Icon(
                              //     size: 80,
                              //     Icons.person,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Theme(
                            data: AppThemes.profileTheme(isEditable),
                            child: SizedBox(
                              height: 55,
                              child: TextField(
                                enabled: isEditable,
                                controller: profileData.userNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
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
                          child: Theme(
                            data: AppThemes.profileTheme(
                                isEditable), // Apply the custom theme
                            child: SizedBox(
                              height: 55,
                              child: TextField(
                                enabled: isEditable,
                                controller: profileData.experienceController,
                                decoration: const InputDecoration(
                                  labelText: 'Experience',
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Theme(
                            data: AppThemes.profileTheme(
                                isEditable), // Apply the custom theme
                            child: SizedBox(
                              height: 55,
                              child: TextField(
                                enabled: isEditable,
                                controller: profileData.priceController,
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Theme(
                            data: AppThemes.profileTheme(
                                isEditable), // Apply the custom theme
                            child: SizedBox(
                              height: 7 * 24.0,
                              child: TextField(
                                maxLines: 10,
                                enabled: isEditable,
                                controller: profileData.bioController,
                                decoration: const InputDecoration(
                                  labelText: 'Bio',
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: editProfile,
                                child: Text('Edit Profile'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  toggleSpinner();
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    await Future.delayed(Duration(seconds: 1));
                                  } finally {
                                    toggleSpinner();
                                    setState(() {
                                      showSpinner = false;
                                      print(profileData);
                                    });
                                  }
                                  _saveUserProfile();
                                },
                                child: const Text('Save Profile'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
