import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../general/search_bar.dart';

class TopContent extends StatelessWidget {
  final dataDummy = ['Hendras', 'Virginia', 'Prawira'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0XFF40407A),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Poster',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 36.0),
              ),
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchBar());
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Icon(
                      EvaIcons.searchOutline,
                      color: Color(0xFF40407A),
                      size: 18,
                    ),
                  ),
                ),
              )
            ],
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
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image(
                            image: AssetImage('assets/images/ticket.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Concert',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image(
                            image: AssetImage('assets/images/person.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Comunity',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image(
                            image: AssetImage('assets/images/trumpet.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Festival',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image(
                            image: AssetImage('assets/images/mosque.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Religion',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
