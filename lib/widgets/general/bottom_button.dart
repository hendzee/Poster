import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;

  BottomButton({ this.title });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFD14081),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20)
          )
      ),
      child: Center(
        child: Text(this.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
