import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegistrationPage({super.key, required this.showLoginPage});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

bool isVisible(){
  if (passwordConfirmed() == false){
    return true;
  } else {
   return false;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 237, 230),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.diamond_outlined,
                          size: 150, color: Color.fromARGB(255, 13, 170, 167)),

                      //text saying Logo
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

                      //email textfield
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 228, 228),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //password
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 228, 228),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //confirm user password / validation
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 228, 228),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: signUp,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 75, 0, 87),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                  child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              ),
                            ),
                          ),
                          ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a member?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: widget.showLoginPage,
                            child: const Text(" Login now",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 13, 170, 167),
                                )),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
