import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 20.0
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0XFF40407A),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50.0),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Poster',
            style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 36.0
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        EvaIcons.headphonesOutline,
                        color: Colors.white,
                      ),
                    ),
                    Text('Concert',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.0,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        EvaIcons.peopleOutline,
                        color: Colors.white,
                      ),
                    ),
                    Text('Comunity',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.0,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        EvaIcons.sunOutline,
                        color: Colors.white,
                      ),
                    ),
                    Text('Festival',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.0,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        EvaIcons.moonOutline,
                        color: Colors.white,
                      ),
                    ),
                    Text('Religion',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
