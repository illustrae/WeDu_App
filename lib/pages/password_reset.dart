import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Text("Password reset email has been sent. "),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(e.message.toString()),
          ),
        );
      } else if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text("The email does not exist in Firebase."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 0, 87),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter your email to recieve a password reset link!"),
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
          Material(
            child: MaterialButton(
                onPressed: () => passwordReset(context),
                color: Color.fromARGB(255, 75, 0, 87),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0))),
          ),
        ],
      ),
    );
  }
}
