import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_detector/focus_detector.dart';
import 'package:poster/cubit/user_cubit.dart';
import 'package:poster/data/user_repository.dart';

import '../modules/local_data.dart';

import 'add_item_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _screenOptions = [
    HomeScreen(),
    ExploreScreen(),
    AddItemScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  final _resumeDetectorKey = UniqueKey();

  // User data bloc
  UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  // On item bottom navigation tapped
  void _onItemTapped(int index, BuildContext context) {
    if (index == 2) {
      Navigator.pushNamed(context, '/add_item');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _userCubit.loadDataUser();

    if (_selectedIndex == 0 || _selectedIndex == 4) {
      FlutterStatusbarcolor.setStatusBarColor(Color(0xFF40407A));
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    } else {
      FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    }

    return Scaffold(
      body: FocusDetector(
        key: _resumeDetectorKey,
        onFocusGained: () {
          if (_selectedIndex == 0 || _selectedIndex == 4) {
            FlutterStatusbarcolor.setStatusBarColor(Color(0xFF40407A));
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
            );
          }
        },
        child: BlocProvider<UserCubit>(
            create: (context) => _userCubit,
            child: _screenOptions.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(
                  _selectedIndex == 0 ? EvaIcons.home : EvaIcons.homeOutline)),
          BottomNavigationBarItem(
              title: Text('Explore'),
              icon: Icon(_selectedIndex == 1
                  ? EvaIcons.compass
                  : EvaIcons.compassOutline)),
          BottomNavigationBarItem(
              title: Text('Add'),
              icon: Icon(
                  _selectedIndex == 2 ? EvaIcons.plus : EvaIcons.plusOutline)),
          BottomNavigationBarItem(
              title: Text('Notification'),
              icon: Icon(
                  _selectedIndex == 3 ? EvaIcons.bell : EvaIcons.bellOutline)),
          BottomNavigationBarItem(
              title: Text('Me'),
              icon: Icon(_selectedIndex == 4
                  ? EvaIcons.person
                  : EvaIcons.personOutline)),
        ],
        onTap: (index) => _onItemTapped(index, context),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0XFFBCC4DB),
        selectedItemColor: Color(0xFF40407A),
      ),
    );
  }
}
