import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:intl/intl.dart' as intl;

/// Class Component a Item Discount Card
class sparepartItem extends StatelessWidget {
  Item item;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  sparepartItem(this.item);

  @override
  Widget build(BuildContext context) {
    final imageNetwork = item.defaultImageUrl ??
        'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

    final formatter = intl.NumberFormat.decimalPattern();
    var nharga = int.parse(item.price.toString());
    var nhargadiskon = int.parse(item.priceDiscount.toString());
    var percent = (nharga - nhargadiskon) / nharga * 100;

    var persenan = percent.toString();
    var persen = persenan.substring(0, 1).toString();
    // var nhargajual = int.parse(widget.aset.hargaJual);
    print(persen);
    // print(otredit);
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 10.0, bottom: 10.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 150,
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
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          height: 180.0,
                          width: 170.0,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0),
                                  bottomLeft: Radius.circular(7.0),
                                  bottomRight: Radius.circular(7.0)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      item.defaultImageUrl!),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                      // Container(
                      //   height: 35.5,
                      //   width: 55.0,
                      //   decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 85, 64, 70),
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(20.0),
                      //           topLeft: Radius.circular(5.0))),
                      //   child: Center(
                      //       child: Text(
                      //     "10%",
                      //     style: TextStyle(
                      //         color: Colors.white, fontWeight: FontWeight.w600),
                      //   )),
                      // )
                    ],
                  ),

                  const Padding(padding: EdgeInsets.only(top: 3.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.type!,
                      maxLines: 1,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          // fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          // fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 15, right: 15.0),
                  //   child: Text(
                  //     ("Otr Mulai dari"),
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //         // letterSpacing: 0.3,
                  //         // color: Colors.black54,
                  //         fontFamily: "Sans",
                  //         // fontWeight: FontWeight.w500,
                  //         fontSize: 11.0),
                  //   ),
                  // ),
                  const Padding(padding: EdgeInsets.only(top: 3.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      nhargadiskon > 0
                          ? 'Rp. ${formatter.format(nhargadiskon)}'
                          : '-',
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.bold,
                          // color: CustomColor.primaryRedColor,
                          fontSize: 16.0),
                    ),
                  ),

                  // const Padding(padding: EdgeInsets.only(top: 1.0)),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 3),
                        height: 20.5,
                        width: 25.0,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 157, 157),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5.0))),
                        child: Center(
                            child: Text(
                          "${persen}% ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              // fontWeight: FontWeight.w600,
                              fontSize: 13),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: nharga > nhargadiskon
                              ? Text(
                                  nharga > 0
                                      ? 'Rp. ${formatter.format(nharga)}'
                                      : '-',
                                  style: TextStyle(
                                      fontFamily: "Sans",
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                      // color: CustomColor.primaryRedColor,
                                      fontSize: 13.0),
                                )
                              : nharga == nhargadiskon
                                  ? Text(
                                      nharga > 0
                                          ? 'Rp. ${formatter.format(nharga)}'
                                          : '-',
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.bold,
                                          // color: CustomColor.primaryRedColor,
                                          fontSize: 13.0),
                                    )
                                  : Text("-")),
                    ],
                  ),

                  // const Padding(padding: EdgeInsets.only(top: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18.0,
                            ),
                            Text(
                              item.reviewRate.toString(),
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Terjual ${item.discussionCount.toString()}",
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 12,
                                // fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
