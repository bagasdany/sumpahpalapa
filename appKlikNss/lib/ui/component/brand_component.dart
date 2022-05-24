import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';

/// Class Component a Item Discount Card
class brandItem extends StatelessWidget {
  Brand brand;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  brandItem(this.brand);

  @override
  Widget build(BuildContext context) {
    // print(otredit);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: marginlvl112,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          // margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomColor.backgroundGrayColor),
          child: Text(brand.text.toString(),
              style: TextStyle(
                fontSize: 13,
                // fontWeight: medium,
              )),
        )
      ]),
    );
  }
}
