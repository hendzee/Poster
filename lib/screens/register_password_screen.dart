import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:poster/cubit/signup_cubit.dart';

class RegisterPasswordScreen extends StatefulWidget {
  @override
  _RegisterPasswordScreenState createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  SignupCubit _signupCubit;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordSecure = true;
  bool _isRePasswordSecure = true;
  String _password = '';
  String _rePassword = '';

  void _handleRegisterPassword(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _signupCubit.registerUser(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    _signupCubit = ModalRoute.of(context).settings.arguments;
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
      body: BlocConsumer<SignupCubit, SignupState>(
        cubit: _signupCubit,
        listener: (context, state) {
          if (state is SignupError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is SignupSucceded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/main',
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return ('Password must be filled');
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: _isPasswordSecure,
                    decoration: InputDecoration(
                      labelText: 'Input Password',
                      prefixIcon: Icon(
                        EvaIcons.lockOutline,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          this.setState(() {
                            _isPasswordSecure =
                                _isPasswordSecure ? false : true;
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
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Re-Password must be filled';
                      } else if (value != _password) {
                        return 'Password must be same at the first';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _rePassword = value;
                    },
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
          );
        },
      ),
    );
  }
}
