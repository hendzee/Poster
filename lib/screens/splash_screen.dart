import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0XFF40407A),
    ));
    return
      Scaffold(
        body: Container(
          color: const Color(0xFF40407A),
          child: Center(
            child: Text(
              'Poster',
              style: TextStyle(
                fontSize: 48.0,
                color: Colors.white,
                fontFamily: 'Pacifico'
              ),
            ),
          ),
        ),
      );
  }
}
