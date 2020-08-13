import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../widgets/home_screen/top_content.dart'; // Substance of home screen
import '../widgets/home_screen/trending_title_content.dart'; // Sunstance of home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0XFF40407A),
    ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopContent(),
              TrendingTitleContent(),
              Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 25.0),
                width: double.infinity,
                height: 220,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Wrap(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5.0,
                                    blurRadius: 7.0,
                                    offset: Offset(0, 3)
                                  )
                                ]
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      width: 160,
                                      height: 180,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0),
                                            child: Text('Concert with James',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Wrap(
                                              children: <Widget>[
                                                Icon(
                                                  EvaIcons.calendarOutline,
                                                  size: 13.0,
                                                ),
                                                SizedBox(width: 5,),
                                                Text('20 Sep, 2020',
                                                  style: TextStyle(fontSize: 12.0),
                                                )
                                              ],
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Wrap(
                                              children: <Widget>[
                                                Icon(
                                                  EvaIcons.pinOutline,
                                                  size: 13.0,
                                                ),
                                                SizedBox(width: 5,),
                                                Text('Sesame street no.10...',
                                                  style: TextStyle(fontSize: 12.0),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                                            child: Text('Desc',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Wrap(
                                            children: <Widget>[
                                              Text('Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum ...',
                                                style: TextStyle(fontSize: 12.0),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      width: 135,
                      child: Container(
                        height: 200,
                        color: Colors.grey,
                        child: Text('Image'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
