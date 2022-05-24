import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';

/// Class Component a Item Discount Card
class lokasiItem extends StatelessWidget {
  City getlokasi;
  double xOffset = 0;
  Offset offset = Offset.zero;
  double yOffset = 0;
  lokasiItem(this.getlokasi);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 10.0, bottom: 10.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  //   child: Text(
                  //     getlokasi.alias!,
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(
                  //         fontFamily: "Sans",
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 14.0),
                  //     textAlign: TextAlign.left,
                  //   ),
                  // ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      getlokasi.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          // fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
