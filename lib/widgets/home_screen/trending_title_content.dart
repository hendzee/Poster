import 'package:flutter/material.dart';

class TrendingTitleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Container(
            color: const Color(0XFF40407A),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(
              left: 25.0,
              top: 25.0
          ),
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
    );
  }
}
