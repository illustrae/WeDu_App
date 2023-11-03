

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
  late final ProfileData profileData = Provider.of<ProfileData>(context);

bool showSpinner = false;

void toggleSpinner() {
  setState((){
  showSpinner = true;


});}

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileData>(
      builder: (BuildContext context, profileData, Widget? child) {  
      child: ModalProgressHUD(
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
                accountName: Text('${profileData.userNameController.text}'),
                accountEmail: Text('Account name'),
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: null,
                // ),
              ),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account Settings',
                  style:TextStyle( color: Color.fromARGB(255, 13, 170, 167)),),
                  onTap: () async {
                    toggleSpinner();
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog.fullscreen(
                          child: const ProfilePage(),
                        );
                        
                      },
                    );
                    Navigator.pop(context);
                  },
                  ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color:Color.fromARGB(255, 13, 170, 167)),
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
