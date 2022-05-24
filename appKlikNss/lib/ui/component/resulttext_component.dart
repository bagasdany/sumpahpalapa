import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_recomendationSearch_model.dart';

import 'package:intl/intl.dart' as intl;

/// Class Component a Item Discount Card
class ResultSearchitemtext extends StatelessWidget {
  Resulttext hasil;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  ResultSearchitemtext(this.hasil);

  @override
  Widget build(BuildContext context) {
    final formatter = intl.NumberFormat.decimalPattern();

    // var nhargajual = int.parse(widget.aset.hargaJual);
    // print(persen);    print("hasil price ${hasil.price}");
    var nharga = 0;
    var nhargadiskon = 0;
    hasil.price != null ? nharga = int.parse(hasil.price.toString()) : 0;

    hasil.priceDiscount != null
        ? nhargadiskon = int.parse(hasil.priceDiscount.toString())
        : 0;
    var percent = (nharga - nhargadiskon) / nharga * 100;

    var persenan = percent.toString();
    var persen = persenan.substring(0, 1).toString();
    var otrasli = hasil.otrPriceFrom.toString();
    var otredit = otrasli.substring(0, 2).toString();
    // print(otredit);
    return hasil.type == "hmc"
        ? Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {},
              child: Container(
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
                                height: 115.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            hasil.defaultImageUrl!),
                                        fit: BoxFit.contain)),
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
                        // Padding(padding: EdgeInsets.only(top: 1.0)),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, right: 15.0),
                          child: Text(
                            ("Honda"),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                // letterSpacing: 0.3,
                                // color: Colors.black54,
                                fontFamily: "Sans",
                                // fontWeight: FontWeight.w500,
                                fontSize: 11.0),
                          ),
                        ),
                        // const Padding(padding: EdgeInsets.only(top: 1)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            hasil.name!,
                            style: const TextStyle(
                                fontFamily: "Sans",
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Card(
                              elevation: 5,
                              // color: Theme.of(context).cardColor.,
                              color: Color.fromARGB(255, 243, 242, 242),
                              shape: BeveledRectangleBorder(
                                //Card with stadium border
                                side: BorderSide(
                                  color: Color.fromARGB(255, 160, 160, 160),
                                  width: 0,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 15),
                              child: SizedBox(
                                width: 70,
                                height: 16,
                                child: Center(
                                  child: Text(
                                    ("cash/kredit"),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        // color: Colors.black54,
                                        fontFamily: "Sans",
                                        // fontWeight: FontWeight.w500,
                                        fontSize: 11.0),
                                  ),
                                ),
                              ),
                            ),
                            const Card(
                              elevation: 5,
                              // color: Theme.of(context).cardColor.,
                              color: Color.fromARGB(255, 243, 242, 242),
                              shape: BeveledRectangleBorder(
                                //Card with stadium border
                                side: BorderSide(
                                  color: Color.fromARGB(255, 160, 160, 160),
                                  width: 0,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 40,
                                height: 16,
                                child: Center(
                                  child: Text(
                                    ("diskon"),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        // color: Colors.black54,
                                        fontFamily: "Sans",
                                        // fontWeight: FontWeight.w500,
                                        fontSize: 11.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.only(top: 15.0)),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, right: 15.0),
                          child: Text(
                            ("Otr Mulai dari"),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                // letterSpacing: 0.3,
                                // color: Colors.black54,
                                fontFamily: "Sans",
                                // fontWeight: FontWeight.w500,
                                fontSize: 11.0),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 1)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, bottom: 10, right: 15.0),
                          child: Text(
                            "${otredit}jt",
                            style: TextStyle(
                                fontFamily: "Sans",
                                fontWeight: FontWeight.bold,
                                color: CustomColor.primaryRedColor,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, bottom: 10.0, right: 5.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 100,
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
                                height: 115.0,
                                width: 170.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0),
                                        bottomLeft: Radius.circular(7.0),
                                        bottomRight: Radius.circular(7.0)),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            hasil.defaultImageUrl!),
                                        fit: BoxFit.fill)),
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            hasil.resultType!,
                            maxLines: 1,
                            style: const TextStyle(
                                fontFamily: "Sans",
                                // fontWeight: FontWeight.bold,
                                fontSize: 10.0),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 3.0)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            hasil.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: "Sans",
                                // fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            nhargadiskon > 0
                                ? 'Rp. ${formatter.format(nhargadiskon)}'
                                : '-',
                            style: TextStyle(
                                fontFamily: "Sans",
                                fontWeight: FontWeight.bold,
                                // color: CustomColor.primaryRedColor,
                                fontSize: 14.0),
                          ),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 3.0)),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              height: 19.5,
                              width: 22.0,
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
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center,
                              )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: nharga > nhargadiskon
                                    ? Text(
                                        nharga > 0
                                            ? 'Rp. ${formatter.format(nharga)}'
                                            : '-',
                                        style: TextStyle(
                                            fontFamily: "Sans",
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                            // color: CustomColor.primaryRedColor,
                                            fontSize: 12.0),
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
                                                fontSize: 12.0),
                                          )
                                        : Text("-")),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 8.0, top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 14.0,
                                  ),
                                  Text(
                                    hasil.reviewRate.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Terjual ${hasil.discussionCount.toString()}",
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
