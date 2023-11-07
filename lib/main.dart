import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_reg/components/profile_data.dart';
import 'package:login_reg/firebase_options.dart';
import 'package:login_reg/auth/main_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //gives access to the native code.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
  
  );

  runApp(const LoginRegApp());
}

class LoginRegApp extends StatelessWidget {
  const LoginRegApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => ProfileData()),
      ],
      child:  MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 127, 57, 137) ),
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
