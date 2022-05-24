import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';

/// Popular Keyword Item class
class KeywordItem extends StatelessWidget {
  @override
  String? title, title2;

  KeywordItem({this.title, this.title2});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: marginlvl2),
          decoration: BoxDecoration(
            color: CustomColor.primaryWhiteColor,
            // borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     blurRadius: 4.5,
            //     spreadRadius: 1.0,
            //   )
            // ],
          ),
          child: Text(
            title!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: CustomColor.primaryBlackColor, fontFamily: "Sans"),
          ),
        ),
        // const Padding(padding: const EdgeInsets.only(top: 15.0)),
      ],
    );
  }
}
