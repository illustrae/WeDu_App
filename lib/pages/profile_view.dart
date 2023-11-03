import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/profile_data.dart';



class ProfileView extends StatefulWidget {
  const ProfileView({required Key key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Fetch the user's own profile data when the page is loaded
    final profileData = Provider.of<ProfileData>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    if (kDebugMode) {
      print(user);
      print(profileData);
    }
    if (user != null) {
      profileData.fetchUserProfile(user.uid);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final profileData = Provider.of<ProfileData>(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<ProfileData>(
        builder: (BuildContext context, profileData, Widget? child) {
          if (profileData.user == null) {
            return CircularProgressIndicator();
          } else {
            // Display the user's profile data using profileData properties
            return Column(
              children: [
                Text('Username: ${profileData.userNameController.text}'),
                Text('Bio: ${profileData.bioController.text}'),
                // Add more fields as needed
              ],
            );
          }
        },
      ),
    );
  }
}
