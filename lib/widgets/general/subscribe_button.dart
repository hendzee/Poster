import 'package:flutter/material.dart';

class SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
                color: Color(0xFFD14081),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                'SUBSCRIBE',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
