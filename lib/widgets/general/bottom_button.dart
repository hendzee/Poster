import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final Function onTap;

  BottomButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFD14081),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
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
