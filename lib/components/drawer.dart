import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 127, 57, 137),
            ),
            accountName: Text('Enter Name'),
            accountEmail: Text('Account name'),
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: null,
            // ),
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Account Settings'),
              onTap: () async {
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
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
