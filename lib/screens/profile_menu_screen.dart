import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  _ProfileMenuScreenState createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  // Navigate to edit profile screen
  void _toEditProfile(BuildContext context) {
    Navigator.pushNamed(context, '/edit_profile');
  }

  // Navigate to change password screen
  void _toChangePassword(BuildContext context) {
    Navigator.pushNamed(context, '/change_password');
  }

  // Handle logout
  _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
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
          title: Text('Profile Menu'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _toEditProfile(context),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Icon(EvaIcons.personOutline),
                    SizedBox(width: 10),
                    Text('Edit Profile'),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                onTap: () => _toChangePassword(context),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Icon(EvaIcons.lockOutline),
                    SizedBox(width: 10),
                    Text('Change Password'),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                onTap: () => _handleLogout(context),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(EvaIcons.logOutOutline),
                    SizedBox(width: 10),
                    Text(
                      'Log Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ));
  }
}
