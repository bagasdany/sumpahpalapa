import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:stacked_services/stacked_services.dart';

/// Class Component a Item Discount Card
class pembiayaanItem extends StatelessWidget {
  Item item;
  ResponseHomeModel viewModel;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  pembiayaanItem(this.item, this.viewModel);

  @override
  Widget build(BuildContext context) {
    final imageNetwork = item.defaultImageUrl ??
        'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

    const sm = "sm: ";
    const koma = ".png";
    // // print("map = ${viewModel.homeEntityModel!.banners![0]}");
    final cek = item.imageUrl;
    print("cek pembiayaan ${cek}");
    final awalIndex = cek!.indexOf(sm);
    final akhirIndex = cek.indexOf(koma, awalIndex + sm.length);
    // //iki gawe tampilan brown fox jumps
    print("awal ${awalIndex}");
    print("akhir pembiayaan ${akhirIndex}");

    final fotosm = cek.substring(awalIndex + sm.length, akhirIndex);
    print("fotosm ${fotosm}");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 10.0, bottom: 5.0, right: 0.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF656565).withOpacity(0.15),
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
                              height: 160,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0),
                                      bottomLeft: Radius.circular(7.0),
                                      bottomRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "${fotosm}.png"),
                                    fit: BoxFit.fill,
                                  )),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              item.text!,
              style: TextStyle(
                  fontFamily: "Sans",
                  // fontWeight: FontWeight.bold,
                  fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class pembiayaanItem2 extends StatelessWidget {
  Item item;
  ResponseHomeModel viewModel;
  double xOffset = 0;

  Offset offset = Offset.zero;
  double yOffset = 0;
  pembiayaanItem2(this.item, this.viewModel);

  @override
  Widget build(BuildContext context) {
    final imageNetwork = item.defaultImageUrl ??
        'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

    const sm = "sm: ";
    const koma = ".png";
    // // print("map = ${viewModel.homeEntityModel!.banners![0]}");
    final cek = item.imageUrl;
    print("cek pembiayaan ${cek}");
    final awalIndex = cek!.indexOf(sm);
    final akhirIndex = cek.indexOf(koma, awalIndex + sm.length);
    // //iki gawe tampilan brown fox jumps
    print("awal ${awalIndex}");
    print("akhir pembiayaan ${akhirIndex}");

    final fotosm = cek.substring(awalIndex + sm.length, akhirIndex);
    print("fotosm ${fotosm}");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 10.0, bottom: 5.0, right: 0.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF656565).withOpacity(0.15),
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
                              height: 160,
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0),
                                      bottomLeft: Radius.circular(7.0),
                                      bottomRight: Radius.circular(7.0)),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "${fotosm}.png"),
                                    fit: BoxFit.fill,
                                  )),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              item.text!,
              style: TextStyle(
                  fontFamily: "Sans",
                  // fontWeight: FontWeight.bold,
                  fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
