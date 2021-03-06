import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:focus_detector/focus_detector.dart';

import '../cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordSecure = true;
  final _resumeDetectorKey = UniqueKey();
  String _email = '';
  String _password = '';
  UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  // Handle login navigation
  void _handleLogin(BuildContext context) {
    _userCubit.login(_email, _password);
  }

  // Handle register navigation
  void _handleRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusDetector(
        key: _resumeDetectorKey,
        onFocusGained: () {
          FlutterStatusbarcolor.setStatusBarColor(Color(0xFF40407A));
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserLoading) {
                  showDialog(
                    context: context,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is UserError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                  Navigator.pop(context);
                } else if (state is UserLoaded) {
                  Navigator.pushReplacementNamed(context, '/main');
                }
                return Container();
              },
              child: Container(
                height: 650,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xFF40407A),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (text) {
                              _email = text;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: Icon(
                                EvaIcons.emailOutline,
                                color: Colors.white,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color(0xFFABABD3),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            onChanged: (text) {
                              _password = text;
                            },
                            obscureText: _isPasswordSecure,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                prefixIcon: Icon(
                                  EvaIcons.personOutline,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordSecure
                                        ? EvaIcons.eyeOff2Outline
                                        : EvaIcons.eyeOutline,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    this.setState(() {
                                      _isPasswordSecure =
                                          _isPasswordSecure ? false : true;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                                labelStyle:
                                    TextStyle(color: Color(0xFFABABD3))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(color: Color(0xFFD14081)),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () => _handleLogin(context),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xFFD14081),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'Dont\' have account yet ?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _handleRegister(context),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF7171A6),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
