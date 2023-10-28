import 'package:flutter/material.dart';
import 'package:login_reg/pages/appointments.dart';

import 'package:login_reg/pages/main_home.dart';
import 'package:login_reg/pages/messages.dart';


//This file is initially the bottom Navigation bar that brings in my other screens(pages)
class HomePage extends StatefulWidget {
  final int initialHomePageIndex;
  const HomePage({super.key, required this.initialHomePageIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _selectedPage = widget.initialHomePageIndex;
  }

  int _selectedPage = 0;

  final pageOptions = [
    const Messages(),
    const Appointments(),
    const MainHome(),
    const MainHome(),
    const Appointments(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 228, 228) ,
      body: IndexedStack(
        index: _selectedPage,
        children: pageOptions,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 154, 76, 164),
          selectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.mail, size: 25), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 25), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 25), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25),
              label: '',
            ),
          ],
          selectedItemColor: Color.fromARGB(255, 13, 170, 167),
          elevation: 10.0,
          unselectedItemColor: Color.fromARGB(255, 243, 237, 230),
          currentIndex: _selectedPage,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
