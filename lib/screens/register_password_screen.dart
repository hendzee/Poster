import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class RegisterPasswordScreen extends StatefulWidget {
  @override
  _RegisterPasswordScreenState createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordSecure = true;
  bool _isRePasswordSecure = true;

  void _handleRegisterPassword(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
        ),
        title: Text('Input Password'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                obscureText: _isPasswordSecure,
                decoration: InputDecoration(
                  labelText: 'Input Password',
                  prefixIcon: Icon(
                    EvaIcons.lockOutline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      this.setState(() {
                        _isPasswordSecure = _isPasswordSecure ? false : true;
                      });
                    },
                    icon: Icon(_isPasswordSecure
                        ? EvaIcons.eyeOff2
                        : EvaIcons.eyeOutline),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: _isRePasswordSecure,
                decoration: InputDecoration(
                  labelText: 'Re-Type Password',
                  prefixIcon: Icon(EvaIcons.lockOutline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      this.setState(
                        () {
                          _isRePasswordSecure =
                              _isRePasswordSecure ? false : true;
                        },
                      );
                    },
                    icon: Icon(
                      _isRePasswordSecure
                          ? EvaIcons.eyeOff2
                          : EvaIcons.eyeOutline,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => _handleRegisterPassword(context),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
