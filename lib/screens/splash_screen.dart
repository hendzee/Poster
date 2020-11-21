import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Navigate to to main screen
  Future _toMain() async {
    return Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void initState() {
    super.initState();
    _toMain();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF40407A));
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
      body: Container(
        color: const Color(0xFF40407A),
        child: Center(
          child: Text(
            'Poster',
            style: TextStyle(
                fontSize: 48.0, color: Colors.white, fontFamily: 'Pacifico'),
          ),
        ),
      ),
    );
  }
}
