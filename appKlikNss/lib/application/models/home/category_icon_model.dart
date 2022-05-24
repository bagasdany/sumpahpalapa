import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';

/// Component category item bellow FlashSale
class CategoryItemValue extends StatelessWidget {
  String? image, title;
  GestureTapCallback? tap;

  CategoryItemValue({
    this.image,
    this.title,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 105.0,
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: AssetImage(image!), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            color: Colors.black.withOpacity(0.25),
          ),
          child: Center(
              child: Text(
            title!,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Berlin",
              fontSize: 18.5,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w800,
            ),
          )),
        ),
      ),
    );
  }
}

/// Component item Menu icon bellow a ImageSlider
class CategoryIconValue extends StatelessWidget {
  String? icon1,
      icon2,
      icon3,
      icon4,
      icon5,
      icon6,
      icon7,
      icon8,
      title1,
      title2,
      title3,
      title4,
      title5,
      title6,
      title7,
      title8;
  GestureTapCallback? tap1, tap2, tap3, tap4, tap5, tap6, tap7, tap8;
  String? size;
  CategoryIconValue(
      {this.icon1,
      this.tap1,
      this.icon2,
      this.tap2,
      this.icon3,
      this.tap3,
      this.icon4,
      this.tap4,
      this.icon5,
      this.tap5,
      this.icon6,
      this.tap6,
      this.icon7,
      this.tap7,
      this.icon8,
      this.tap8,
      this.title1,
      this.title2,
      this.title3,
      this.title4,
      this.title5,
      this.title6,
      this.title7,
      this.title8,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 20.0)),
        // const Padding(padding: EdgeInsets.only(top: 0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 60,
              // height: marginlvl8,
              child: InkWell(
                // onTap: tap1,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: icon1.toString(),
                        height: marginlvl5,
                        fit: BoxFit.fill,
                        width: marginlvl5,
                      ),
                    ),
                    // Image.asset(
                    //   icon1!,
                    //   height: 19.2,
                    // ),
                    // SvgPicture.asset(
                    //   'assets/img/motorcycle.svg',
                    //   width: 26,
                    //   height: 26,
                    // ),
                    // Padding(padding: EdgeInsets.only(top: 7.0)),
                    Center(
                      child: Text(
                        title1!,
                        style: const TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: marginlvl8,
              width: MediaQuery.of(context).size.width * 0.2,
              child: InkWell(
                onTap: tap2,
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   icon2!,
                    //   height: 26.2,
                    // ),
                    CachedNetworkImage(
                      imageUrl: icon2.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    // Padding(padding: EdgeInsets.only(top: 0.0)),
                    Center(
                      child: Text(
                        title2!,
                        style: const TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap3,
                child: Column(
                  children: <Widget>[
                    // SvgPicture.asset(
                    //   'assets/img/pembiayaan.svg',
                    //   width: 26,
                    //   height: 26,
                    // ),
                    CachedNetworkImage(
                      imageUrl: icon3.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    // Padding(padding: EdgeInsets.only(top: 4.0)),
                    Text(
                      title3!,
                      style: const TextStyle(
                        fontFamily: "Sans",
                        fontSize: 12.0,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap4,
                child: Column(
                  children: <Widget>[
                    // SvgPicture.asset(
                    //   'assets/img/gear.svg',
                    //   width: 26,
                    //   height: 26,
                    // ),
                    CachedNetworkImage(
                      imageUrl: icon4.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    // const Padding(padding: EdgeInsets.only(top: 4.0)),
                    Text(
                      title4!,
                      style: const TextStyle(
                        fontFamily: "Sans",
                        fontSize: 12.0,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const Padding(padding: const EdgeInsets.only(top: 10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap5,
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   icon1!,
                    //   height: 19.2,
                    // ),
                    // SvgPicture.asset(
                    //   'assets/img/motorcycle.svg',
                    //   width: 26,
                    //   height: 26,
                    // ),
                    CachedNetworkImage(
                      imageUrl: icon5.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),

                    Center(
                      child: Text(
                        title5!,
                        style: const TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap6,
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   icon2!,
                    //   height: 26.2,
                    // ),
                    // SvgPicture.asset(
                    //   'assets/img/pembiayaan.svg',
                    //   width: 26,
                    //   height: 26,
                    // ),
                    CachedNetworkImage(
                      imageUrl: icon6.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    Center(
                      child: Text(
                        title6!,
                        style: const TextStyle(
                          fontFamily: "Sans",
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap7,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: icon7.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    Text(
                      title7!,
                      style: const TextStyle(
                        fontFamily: "Sans",
                        fontSize: 12.0,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: marginlvl8,
              child: InkWell(
                onTap: tap8,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: icon8.toString(),
                      height: marginlvl5,
                      fit: BoxFit.fill,
                      width: marginlvl5,
                    ),
                    // Padding(padding: EdgeInsets.only(top: 4.0)),
                    Text(
                      title8!,
                      style: const TextStyle(
                        fontFamily: "Sans",
                        fontSize: 12.0,
                        // fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
