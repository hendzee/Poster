import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  Color color;

  BottomButton({this.title, this.onTap, this.color = const Color(0xFFD14081)});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
