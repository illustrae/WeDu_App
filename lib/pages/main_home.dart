import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/components/topcards.dart';
import 'package:provider/provider.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final user = FirebaseAuth.instance.currentUser;
  final currentDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    // Fetch the user's own profile data when the page is loaded
    late final profileData = Provider.of<ProfileData>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      profileData.fetchUserProfile(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.MMMEd().format(currentDate);
    return Consumer<ProfileData>(
        builder: (BuildContext context, profileData, Widget? child) {
      return Scaffold(
        extendBody: true,
        // backgroundColor: Color.fromARGB(255, 127, 69, 136),
        body: Container(
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
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // text name ${user!.email}
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back, ${profileData.userNameController.text} ",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(formattedDate,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: "Poppins",
                                letterSpacing: -0.3,
                              ))
                        ],
                      ),
                      IconButton.filled(
                        color: const Color.fromARGB(255, 243, 237, 230),
                        style: IconButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 154, 76, 164)),
                        iconSize: 20,
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          // ...
                        },
                      ),
                    ],
                  ),
                ),

                //Search bar...
                Container(
                  height: 60,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: SearchBar(
                      hintText: "Search...",
                      leading: Icon(Icons.search_rounded,
                          color: Color.fromARGB(255, 103, 5, 116),
                          weight: 10.0),
                    ),
                  ),
                ),

                //Category and boxes
                const Text(
                  "CATEGORY",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Color.fromARGB(255, 13, 170, 167),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TopCards(),
                        TopCards(),
                        TopCards(),
                        TopCards(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Bottom planners list
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      color: const Color.fromARGB(255, 243, 228, 228),
                      height: 100,
                      width: double.infinity,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "TOP RATED",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 13, 170, 167),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
