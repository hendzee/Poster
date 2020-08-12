import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  /// Navigate to to main screen
  void _toMain(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

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
            child: GestureDetector(
              onTap: () => _toMain(context),
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
        ),
      );
  }
}
