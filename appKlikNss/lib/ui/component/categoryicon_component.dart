import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:stacked_services/stacked_services.dart';

/// Class Component a Item Discount Card
class iconItem extends StatelessWidget {
  // Item item;
  double xOffset = 0;
  ResponseHomeModel homeModel;
  Offset offset = Offset.zero;
  double yOffset = 0;
  iconItem(this.homeModel);

  @override
  Widget build(BuildContext context) {
    // final imageNetwork = homeModel.categories![0].imageUrl ??
    //     'https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
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
                              height: 30.0,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            "",
            // homeModel.categories![0].text.toString(),
            style: const TextStyle(
                fontFamily: "Sans",
                // fontWeight: FontWeight.bold,
                fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
