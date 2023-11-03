import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/profile_data.dart';



class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}



class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileData>(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<ProfileData>(
        builder: (BuildContext context, profileData, Widget? child) {
          if (profileData.user == null) {
            // You might want to show a loading indicator here while data is loading.
            return CircularProgressIndicator();
          } else {
            return ListView(
              itemCount: 1, // Since you're showing one user's profile
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Username: ${profileData.userNameController.text}'),
                  subtitle: Text('Bio: ${profileData.bioController.text}'),
                  // Add more fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
