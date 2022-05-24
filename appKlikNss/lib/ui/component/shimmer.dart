import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:shimmer/shimmer.dart';

class loadingMenuItemDiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 0.0, left: 0.0, top: 0.0, bottom: 0),
          child: Wrap(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Color(0xFF656565).withOpacity(0.15),
                highlightColor: Colors.white,
                child: Container(
                  height: marginlvl5,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: .0, top: 10.0),
                        child: Container(
                          height: marginlvl4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 10.0),
                        child: Container(
                          height: marginlvl4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 15),
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
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 185.0,
                                    width: 160.0,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 5.0,
                                    top: 12.0,
                                    bottom: 10),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 15),
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
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 185.0,
                                    width: 160.0,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 5.0,
                                    top: 12.0,
                                    bottom: 10),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 15, bottom: 20, top: 20),
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
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 185.0,
                                    width: 160.0,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 12.0),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 5.0,
                                    top: 12.0,
                                    bottom: 10),
                                child: Container(
                                  height: 9.5,
                                  width: 130.0,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
