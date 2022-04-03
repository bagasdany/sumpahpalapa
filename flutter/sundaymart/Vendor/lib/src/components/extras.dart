import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Extras extends StatefulWidget {
  final List extras;
  final Function(List) onChange;
  const Extras({Key? key, required this.extras, required this.onChange})
      : super(key: key);

  @override
  _ExtrasState createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
  List tempExtrasState = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 1.sw - 30,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: HexColor("#ECEFF3"),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.extras.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    if (item['type'] == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${item['language']['name']}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                letterSpacing: -0.5,
                                color: HexColor("#000000"),
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: item['extras'].map<Widget>((e) {
                              int index = tempExtrasState.indexOf(e);

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    int ind = tempExtrasState.indexWhere(
                                        (element) =>
                                            element['id_extra_group'] ==
                                            item['id']);

                                    if (index == -1) {
                                      if (ind > -1) {
                                        tempExtrasState.removeAt(ind);
                                      }
                                      e['id_product'] = item["id_product"];
                                      tempExtrasState.add(e);
                                    } else {
                                      tempExtrasState.removeAt(index);
                                    }
                                  });

                                  widget.onChange(tempExtrasState);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.all(15),
                                    width: 0.5.sw - 40,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: index == -1
                                            ? HexColor("#ffffff")
                                            : HexColor("#16AA16"),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1,
                                            color: HexColor("#E9E9E6"))),
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$globalImageUrl${e['image_url']}",
                                            height: 70,
                                            width: 0.5.sw - 40,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fitHeight,
                                                  // colorFilter:
                                                  //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              width: 60,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                const IconData(0xee4b,
                                                    fontFamily: 'MIcon'),
                                                color: const Color.fromRGBO(
                                                    233, 233, 230, 1),
                                                size: 40.sp,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Divider(
                                          color: HexColor("#000000")
                                              .withOpacity(0.05),
                                        ),
                                        Text(
                                          "${e['language']['name']}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Inter',
                                              letterSpacing: -0.5,
                                              color: index != -1
                                                  ? HexColor("#ffffff")
                                                  : HexColor("#000000"),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                              );
                            }).toList(),
                          )
                        ],
                      )
                    else if (item['type'] == 2)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${item['language']['name']}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Inter',
                                  letterSpacing: -0.5,
                                  color: HexColor("#000000"),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: item['extras'].map<Widget>((e) {
                                int index = tempExtrasState.indexOf(e);

                                return InkWell(
                                  child: Container(
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 5),
                                    height: 20,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: index != -1
                                                ? HexColor(
                                                    e['background_color'])
                                                : Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              HexColor(e['background_color'])),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      int ind = tempExtrasState.indexWhere(
                                          (element) =>
                                              element['id_extra_group'] ==
                                              item['id']);

                                      if (index == -1) {
                                        if (ind > -1) {
                                          tempExtrasState.removeAt(ind);
                                        }
                                        e['id_product'] = item["id_product"];
                                        tempExtrasState.add(e);
                                      } else {
                                        tempExtrasState.removeAt(index);
                                      }
                                    });

                                    widget.onChange(tempExtrasState);
                                  },
                                );
                              }).toList(),
                            )
                          ])
                    else if (item['type'] == 3)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${item['language']['name']}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Inter',
                                  letterSpacing: -0.5,
                                  color: HexColor("#000000"),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              children: item['extras'].map<Widget>((e) {
                                int index = tempExtrasState.indexOf(e);

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      int ind = tempExtrasState.indexWhere(
                                          (element) =>
                                              element['id_extra_group'] ==
                                              item['id']);

                                      if (index == -1) {
                                        if (ind > -1) {
                                          tempExtrasState.removeAt(ind);
                                        }
                                        e['id_product'] = item["id_product"];
                                        tempExtrasState.add(e);
                                      } else {
                                        tempExtrasState.removeAt(index);
                                      }
                                    });

                                    widget.onChange(tempExtrasState);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: index == -1
                                              ? HexColor("#ffffff")
                                              : HexColor("#16AA16"),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1,
                                              color: HexColor("#E9E9E6"))),
                                      child: Text(
                                        "${e['language']['name']}",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            letterSpacing: -0.5,
                                            color: index != -1
                                                ? HexColor("#ffffff")
                                                : HexColor("#000000"),
                                            fontWeight: FontWeight.w500),
                                      )),
                                );
                              }).toList(),
                            )
                          ])
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
