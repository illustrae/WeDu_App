import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/components/topcards.dart';
import 'package:login_reg/pages/profiles_of_others.dart';
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${profileData.userNameController.text}! ",
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
                    color: Colors.black,
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TopCards(text: 'Entertainers', icon:Icon(Icons.music_note_rounded, color: Colors.black, size:30)),
                        TopCards(text: 'Venues',icon:Icon(Icons.church_rounded, color: Colors.black, size:30)),
                        TopCards(text: 'Photographers',icon:Icon(Icons.camera_enhance, color: Colors.black, size:30)),
                        TopCards(text: 'Catering', icon:Icon(Icons.food_bank, color: Colors.black, size:30)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Specialist",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),

                //Bottom planners list
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      color: const Color.fromARGB(255, 243, 228, 228),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('profiles')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                final documents = snapshot.data!.docs;
                                final currentUserUid =
                                    FirebaseAuth.instance.currentUser?.uid;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    final document = documents[index];
                                    final data =
                                        document.data() as Map<String, dynamic>;
                                    final profileUid = data['user_id'];
                                    if (currentUserUid == profileUid) {
                                      return const SizedBox.shrink();
                                    }
                                    return ListTile(
                                      leading: data['profileImageUrl'] != ""
                                          ? ClipOval(
                                              child: Image.network(
                                                data['profileImageUrl'],
                                                fit: BoxFit.fill,
                                                width: 50,
                                                height: 50,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person,
                                              size: 50,
                                            ),
                                      title: Text(
                                        data['username'],
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 13, 170, 167)),
                                      ),
                                      subtitle: Text(data['service']),
                                      trailing: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilesOfOthers(
                                                      userData: data),
                                            ),
                                          );
                                        },
                                        style : ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                                                255, 13, 170, 167),),),
                                        child: Text(style:TextStyle(color: Colors.black),'Visit'),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
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
