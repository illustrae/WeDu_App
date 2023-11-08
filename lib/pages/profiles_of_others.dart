import 'package:flutter/material.dart';

class ProfilesOfOthers extends StatelessWidget {
  final Map<String, dynamic> userData;
  const ProfilesOfOthers({super.key, required this.userData});
    

 
@override
  Widget build(BuildContext context) {
    // Use userData to display the user's profile dynamically.
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['username']), // For example, display the username.
      ),
      body: Center(
        child: Column(
          children: [
            // Display user data from userData map.
            Text('Username: ${userData['username']}'),
            Text('Service: ${userData['service']}'),
            // Add more user information as needed.
          ],
        ),
      ),
    );
  }
}