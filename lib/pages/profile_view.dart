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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 57, 137),
      extendBody: true,
      body: Consumer<ProfileData>(
        builder: (context, profileData, child) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: 1200,
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Color.fromARGB(255, 243, 237, 230),
                            child: profileData
                                    .profileImageUrlController.text.isNotEmpty
                                ? Image.network(
                                    profileData.profileImageUrlController.text)
                                : Icon(
                                    size: 80,
                                    Icons.person,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        '${profileData.userNameController.text}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 13, 170, 167),
                          fontFamily: "Poppins",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 243, 237, 230),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Experience: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 243, 237, 230),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Price: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 243, 237, 230),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileData.selectedService,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                profileData.experienceController.text,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                profileData.priceController.text,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: const Text(
                      'Bio',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 13, 170, 167),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                profileData.bioController.text,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 243, 237, 230),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w100,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
