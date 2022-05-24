import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:shimmer/shimmer.dart';

class shimmerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0, right: 0),
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
              child: Column(
                children: [
                  Wrap(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 65.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black12,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 40.0,
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.13,
                                                  color: Color(0xFF656565)
                                                      .withOpacity(0.15),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20, top: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20, top: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20, top: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
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
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black12,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 10.0,
                                                margin: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                color: Color(0xFF656565)
                                                    .withOpacity(0.15),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, bottom: 0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
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
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black12,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 40.0,
                                                  margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.13,
                                                  color: Color(0xFF656565)
                                                      .withOpacity(0.15),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              color: Color(0xFF656565)
                                                  .withOpacity(0.15),
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
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black12,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 10.0,
                                                margin: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                color: Color(0xFF656565)
                                                    .withOpacity(0.15),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, bottom: 0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
                                          ),
                                          Container(
                                            height: 10.0,
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: Color(0xFF656565)
                                                .withOpacity(0.15),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class shimmerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0, right: 0),
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
                  Shimmer.fromColors(
                    baseColor: Colors.black38,
                    highlightColor: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black12,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 40.0,
                                          margin: EdgeInsets.all(20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.13,
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class shimmerIconbanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0, right: 0),
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
                  Shimmer.fromColors(
                    baseColor: Colors.black38,
                    highlightColor: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 300.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
