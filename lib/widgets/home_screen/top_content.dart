import 'package:flutter/material.dart';

class TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 20.0
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0XFF40407A),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(70.0),
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
                        Icons.music_note,
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
                        Icons.people,
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
                        Icons.filter_vintage,
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
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    Text('Seminar',
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
