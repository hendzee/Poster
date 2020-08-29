import 'package:flutter/material.dart';
import 'package:poster/screens/add_item_screen.dart';
import './screens/splash_screen.dart';
import './screens/main_screen.dart';
import './screens/add_item_screen.dart';
import './screens/detail_item_screen.dart';

void main() {
  runApp(Poster());
}

class Poster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        primaryColor: Color(0xFF40407A),
        appBarTheme: AppBarTheme(
          elevation: 0.5,
        )
      ),
      initialRoute: '/main',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
        '/add_item': (context) => AddItemScreen(),
        '/detail_item': (context) => DetailItemScreen()
      },
    );
  }
}