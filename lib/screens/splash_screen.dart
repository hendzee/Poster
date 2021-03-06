import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:poster/cubit/user_cubit.dart';

import '../modules/local_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserCubit _userCubit;

  /// Navigate to to main screen
  Future _toMain() async {
    // Check user local data exsitension
    bool isLogin = await LocalData.getLoginLocalData();

    return Timer(Duration(seconds: 3), () async {
      // Direct to main if logged
      if (isLogin) {
        await _userCubit.loadDataUser();
        Navigator.of(context).pushReplacementNamed('/main');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
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
