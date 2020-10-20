import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/models/notification_card_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationCardModel cardModel;
  NotificationCard({this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                EvaIcons.closeCircle,
                color: Color(0xFFD14081),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    width: 50,
                    height: 70,
                    fit: BoxFit.contain,
                    image: AssetImage(this.cardModel.image),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      this.cardModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(this.cardModel.eventTime),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      this.cardModel.notifTime,
                      style: TextStyle(fontSize: 12, color: Color(0xFFCED6E0)),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
