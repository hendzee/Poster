import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _screenOptions = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
  ];
  
  // On item bottom navigation tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(_selectedIndex == 0 ? EvaIcons.home : EvaIcons.homeOutline)
          ),
          BottomNavigationBarItem(
              title: Text('Explore'),
              icon: Icon(_selectedIndex == 1 ? EvaIcons.compass : EvaIcons.compassOutline)
          ),
          BottomNavigationBarItem(
              title: Text('Add'),
              icon: Icon(_selectedIndex == 2 ? EvaIcons.plus : EvaIcons.plusOutline)
          ),
          BottomNavigationBarItem(
              title: Text('Notification'),
              icon: Icon(_selectedIndex == 3 ? EvaIcons.bell : EvaIcons.bellOutline)
          ),
          BottomNavigationBarItem(
              title: Text('Me'),
              icon: Icon(_selectedIndex == 4 ? EvaIcons.person : EvaIcons.personOutline)
          ),
        ],
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0XFFBCC4DB),
        selectedItemColor: Color(0xFF40407A),
      ),
    );
  }
}