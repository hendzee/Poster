import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Handle register profile
  void _handleRegisterProfile(BuildContext context) {
    Navigator.pushNamed(context, '/register_password');
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
        title: Text('Input Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(
                    EvaIcons.person,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: Icon(EvaIcons.emailOutline),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => _handleRegisterProfile(context),
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
