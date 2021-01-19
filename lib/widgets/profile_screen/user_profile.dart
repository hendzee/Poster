import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';

class UserProfile extends StatelessWidget {
  final UserModel user;

  UserProfile(this.user);

  // Navigate to profile menu list page
  void toProfileMenu(BuildContext context) {
    Navigator.pushNamed(context, '/profile_menu');
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/dummy_images/user1.png')),
            SizedBox(
              width: 10,
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 130),
                  child: Text(
                    user.firstName + ' ' + user.lastName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    toProfileMenu(context);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFFD14081),
                    child: Icon(
                      EvaIcons.edit2Outline,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
