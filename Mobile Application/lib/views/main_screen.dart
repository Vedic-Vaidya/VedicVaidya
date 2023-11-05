import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herbal_veda_copy/views/screens/history_screen.dart';
import 'package:herbal_veda_copy/views/screens/home_screen.dart';
import 'package:herbal_veda_copy/views/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        
        unselectedItemColor: Colors.black,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex= value;
          });
        },
        selectedItemColor: Color.fromRGBO(102, 128, 52, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), 
            label: 'HOME'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history), 
            label: 'HISTORY'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), 
            label: 'PROFILE'
          ),
         
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}