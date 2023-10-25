import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 237, 230),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(children: [
                //text saying hello
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "WeDU",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 35,
                        color: Color.fromARGB(255, 75, 0, 87),
                        letterSpacing: .5,
                        fontWeight: FontWeight.w900),
                  ),
                ),

                const Text("Crafting Forever Starts Here",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),

                //email texfield
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 228, 228),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                //password
              ]),
            ),
          ),
        ));
  }
}
