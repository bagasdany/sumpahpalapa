import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_search_model.dart';
import 'package:mobileapps/ui/views/home/resultSearch_viewmodel.dart';
import 'package:mobileapps/ui/views/home/search_viewmodel.dart';

/// Class Component a Item Discount Card
class RekomendasiItemText extends StatelessWidget {
  History history;

  double xOffset = 0;
  Offset offset = Offset.zero;
  double yOffset = 0;
  RekomendasiItemText(this.history);

  @override
  Widget build(BuildContext context) {
    // print(otredit);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: marginlvl2,
            ),
            decoration: BoxDecoration(
              color: CustomColor.primaryWhiteColor,
            ),
            child: GestureDetector(
              onTap: () {
                var key = history.text.toString();
                resultSearchViewModel().resultSearchApitext(
                  key,
                );
              },
              child: Text(
                history.text.toString(),
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: CustomColor.primaryBlackColor, fontFamily: "Sans"),
              ),
            ),
          ),
          // const Padding(padding: const EdgeInsets.only(top: 15.0)),
        ],
      ),
    );
  }
}
