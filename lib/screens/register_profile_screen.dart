import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:poster/cubit/signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/data/signup_repository.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignupCubit _signupCubit = SignupCubit(ImpSignupRepository());
  String _firstName;
  String _lastName;
  String _email;

  // Handle register profile
  void _handleRegisterProfile() {
    if (_formKey.currentState.validate()) {
      _signupCubit.registerProfile(_firstName, _lastName, _email);
    }
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
        body: BlocConsumer<SignupCubit, SignupState>(
          cubit: _signupCubit,
          listener: (context, state) {
            if (state is SignupProfileSaved) {
              Navigator.pushNamed(
                context,
                '/register_password',
                arguments: _signupCubit,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'First name cant be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _firstName = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              prefixIcon: Icon(
                                EvaIcons.person,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Last name cant be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _lastName = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email cant be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Your Email',
                        prefixIcon: Icon(EvaIcons.emailOutline),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => _handleRegisterProfile(),
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
        ));
  }
}
