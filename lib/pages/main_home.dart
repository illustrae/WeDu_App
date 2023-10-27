import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final user = FirebaseAuth.instance.currentUser;
  final currentDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.MMMEd().format(currentDate);
    return SafeArea(
      child: Scaffold(
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
                          const Text(
                            "Welcome Back, Trae! ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text("$formattedDate",
                          style:TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            letterSpacing: -0.3,

                          ))
                        ],
                      ),
                      IconButton.filled(
                        color: Color.fromARGB(255, 243, 237, 230),
                        style: IconButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 154, 76, 164)),
                        iconSize: 20,
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          // ...
                        },
                      ),
                    ],
                  ),
                ),
                  Material(
                child: MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  color: Color.fromARGB(255, 75, 0, 87),
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
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