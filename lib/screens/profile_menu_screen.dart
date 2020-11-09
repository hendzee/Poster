import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: Icon(
              EvaIcons.arrowBackOutline,
              color: Colors.white,
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
            Divider(
              color: Colors.black,
            ),
          ],
        ));
  }
}
