import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_search_model.dart';

/// Class Component a Item Discount Card
class RekomendasiItemMotor extends StatelessWidget {
  Item item;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  RekomendasiItemMotor(this.item);

  @override
  Widget build(BuildContext context) {
    final imageNetwork = item.defaultImageUrl ??
        'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

    var otrasli = item.otrPriceFrom.toString();
    var otredit = otrasli.substring(0, 2).toString();
    // print(otredit);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 10.0),
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
                          height: 100.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      item.defaultImageUrl!),
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
                          fontSize: 10.0),
                    ),
                  ),
                  // const Padding(padding: EdgeInsets.only(top: 3.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.name!,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(bottom: 5.0)),
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
                          width: 57,
                          height: 16,
                          child: Center(
                            child: Text(
                              ("cash/kredit"),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  letterSpacing: 0.3,
                                  // color: Colors.black54,
                                  fontFamily: "Sans",
                                  // fontWeight: FontWeight.w500,
                                  fontSize: 10.0),
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
                        margin: EdgeInsets.only(left: 4, right: 15),
                        child: SizedBox(
                          width: 36,
                          height: 16,
                          child: Center(
                            child: Text(
                              ("diskon"),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  letterSpacing: 0.3,
                                  // color: Colors.black54,
                                  fontFamily: "Sans",
                                  // fontWeight: FontWeight.w500,
                                  fontSize: 10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 7.0)),
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
                  // const Padding(padding: EdgeInsets.only(top: 3.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "${otredit}jt",
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.bold,
                          color: CustomColor.primaryRedColor,
                          fontSize: 14.0),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 5.0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Row(
                  //         children: <Widget>[
                  //           Text(
                  //             item.name!,
                  //             style: TextStyle(
                  //                 fontFamily: "Sans",
                  //                 color: Colors.black26,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 12.0),
                  //           ),
                  //           Icon(
                  //             Icons.star,
                  //             color: Colors.yellow,
                  //             size: 14.0,
                  //           )
                  //         ],
                  //       ),
                  //       Text(
                  //         item.otrPriceFrom!.toString(),
                  //         style: TextStyle(
                  //             fontFamily: "Sans",
                  //             color: Colors.black26,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 12.0),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
