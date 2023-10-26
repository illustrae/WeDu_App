import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_reg/pages/password_reset.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegistrationPage;
  const LoginPage({super.key, required this.showRegistrationPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Authentication Error"),
          content: Text("Wrong email or password. Please try again."),
        ),
      );
    }
  }

//removes the data when not being used.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 237, 230),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.diamond_outlined,
                          size: 150, color: Color.fromARGB(255, 13, 170, 167)),

                      //text saying Logo---------
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

                      const Text(
                        "Let's Continue the Journey Together",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      //email textfield
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 228, 228),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //password-------------

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 228, 228),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      //forgot password ----------------

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PasswordResetPage();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 13, 170, 167),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: signIn,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 75, 0, 87),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign in",
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
                          Text("Not a member?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: widget.showRegistrationPage,
                            child: Text(
                              " Register now",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 170, 167),
                              ),
                            ),
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
