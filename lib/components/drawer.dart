// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/pages/profile_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser;

  bool showSpinner = false;

  void toggleSpinner() {
    setState(() {
      showSpinner = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileData>(
      builder: (BuildContext context, profileData, Widget? child) {
        ProfileData profileData = Provider.of<ProfileData>(context);
        print(profileData);
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Drawer(
            backgroundColor: Color.fromARGB(255, 243, 228, 228),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 127, 57, 137),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: profileData.profileImageUrlController.text.isEmpty
                          ? Icon(Icons.person,
                              size:
                                  50) // Show an icon if the profile image URL is empty
                          : Image.network(
                              profileData.profileImageUrlController.text,
                              fit: BoxFit.fill,
                              width: 200,
                              height: 200,
                            ),
                    ),
                  ),
                  accountName: Text(
                      profileData.userNameController.text.isNotEmpty
                          ? '${profileData.userNameController.text}'
                          : 'New User'),
                  accountEmail: Text('${user?.email}'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Account Settings',
                    style: TextStyle(color: Color.fromARGB(255, 13, 170, 167)),
                  ),
                  onTap: () async {
                    toggleSpinner();

                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog.fullscreen(
                          child: ProfilePage(),
                        );
                      },
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app,
                      color: Color.fromARGB(255, 13, 170, 167)),
                  title: Text('Sign Out'),
                  onTap: () {
                    Navigator.pop(context);
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
