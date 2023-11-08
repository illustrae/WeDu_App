import 'package:flutter/material.dart';

class ProfilesOfOthers extends StatelessWidget {
  final Map<String, dynamic> userData;
  const ProfilesOfOthers({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
              elevation: 3,
              shadowColor: Colors.black,
              centerTitle: true,
              title: const Text("WeDU"),
              titleTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 13, 170, 167),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
              backgroundColor: const Color.fromARGB(255, 127, 57, 137),
            ),
      backgroundColor: const Color.fromARGB(255, 127, 57, 137),
      extendBody: true,
      body: SingleChildScrollView(
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
                // margin: EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 243, 237, 230),
                        child: '${userData['profileImageUrl']}' != ""
                            ? ClipOval(
                                child: Image.network(
                                  '${userData['profileImageUrl']}',
                                  fit: BoxFit.fill,
                                  width: 350,
                                  height: 350,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 80,
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
                    '${userData['username']}',
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
                            '${userData['service']}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${userData['Experience']}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 243, 237, 230),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${userData['price']}',
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
                            '${userData['bio']}',
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
      ),
    );
  }
}
