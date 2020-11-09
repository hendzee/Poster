import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../widgets/general/bottom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isCurrentPasswordSecure = true;
  bool _isNewPasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(
            EvaIcons.arrowBackOutline,
            color: Colors.white,
          ),
        ),
      ),
      bottomSheet: BottomButton(
        title: 'SAVE',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  obscureText: _isCurrentPasswordSecure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(EvaIcons.lockOutline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isCurrentPasswordSecure
                            ? EvaIcons.eyeOff2Outline
                            : EvaIcons.eyeOutline,
                      ),
                      onPressed: () {
                        this.setState(() {
                          _isCurrentPasswordSecure =
                              _isCurrentPasswordSecure ? false : true;
                        });
                      },
                    ),
                    labelText: 'Current Password',
                  ),
                ),
                TextField(
                  obscureText: _isNewPasswordSecure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(EvaIcons.lockOutline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordSecure
                            ? EvaIcons.eyeOff2Outline
                            : EvaIcons.eyeOutline,
                      ),
                      onPressed: () {
                        this.setState(() {
                          _isNewPasswordSecure =
                              _isNewPasswordSecure ? false : true;
                        });
                      },
                    ),
                    labelText: 'New Password',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
