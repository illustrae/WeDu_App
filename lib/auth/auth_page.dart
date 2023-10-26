import 'package:flutter/material.dart';
import 'package:login_reg/pages/login_page.dart';
import 'package:login_reg/pages/registration_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(showRegistrationPage: toggleScreens);
    } else {
      return RegistrationPage(showLoginPage: toggleScreens);
    }
  }
}