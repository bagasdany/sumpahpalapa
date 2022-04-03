import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageSent extends StatelessWidget {
  final String? text;
  final String? time;
  const MessageSent({this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            constraints: BoxConstraints(maxWidth: 0.7.sw),
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                color: Color.fromRGBO(255, 255, 255, 1)),
            child: Text(
              "$text",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  letterSpacing: -0.5,
                  color: Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
          Text(
            "$time",
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                height: 1.2,
                letterSpacing: -0.5,
                color: Color.fromRGBO(136, 136, 126, 1)),
          ),
        ],
      ),
    );
  }
}
