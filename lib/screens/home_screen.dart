import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/home_screen/top_content.dart'; // Substance of home screen

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
            children: <Widget>[
              TopContent(),
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 700,
                    child: Container(
                      color: const Color(0XFF40407A),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 700,
                    padding: EdgeInsets.all(35.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70.0)
                      )
                    ),
                    child: Text('TRENDING!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
