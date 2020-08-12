import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(Poster());
}

class Poster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}