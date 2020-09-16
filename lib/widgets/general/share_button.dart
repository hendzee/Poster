import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
                color: Color(0xFFE3E8E9),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                'SHARE',
                style: TextStyle(fontSize: 10, color: Color(0xFF91A2A6)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
