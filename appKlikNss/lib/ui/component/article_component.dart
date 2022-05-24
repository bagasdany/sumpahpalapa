import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:intl/intl.dart' as intl;

/// Class Component a Item Discount Card
class artikelItem extends StatelessWidget {
  Item item;
  double xOffset = 0;
  Offset offset = Offset.zero;
  double yOffset = 0;
  artikelItem(this.item);
  void convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print("dt 5 string ${todayDate}");
    print(formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
  }

  @override
  Widget build(BuildContext context) {
    String convertToAgo(DateTime? input) {
      Duration diff = DateTime.now().difference(input!);

      if (diff.inDays >= 1) {
        return '${diff.inDays} hari lalu';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} jam lalu';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} menit lalu';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} detik lalu';
      } else {
        return 'just now';
      }
    }

    DateTime? time1 = item.updatedAt;
    print("cek cek ${convertToAgo(time1)}");
    var lastdate = convertToAgo(time1);
    DateTime time2 = DateTime.utc(2022, 02, 9);
    print("tangs ${convertToAgo(time2)}");

    final imageNetwork = item.defaultImageUrl ??
        'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';
    print("tanggal ${item.updatedAt}");
    DateTime dt2 = DateTime.now();
    DateTime? dt44 = DateTime.parse("2018-09-12");
    DateTime? dt4 = DateTime.now();
    DateTime? dt5 = DateTime.now();

    item.updatedAt != null ? dt4 = item.updatedAt : dt4 = dt2;
    // // widget.aset.tglSewa != null ? dt5 = widget.aset.tglSewa : dt5 = dt2;
    // print("dt5 ${dt5}");
    // print("dt5 hari ${item.title}");
    // print("dt 5 cek ${new intl.DateFormat('yyyy/MM/dd').parse('x')}");
    // print("dt5 tanggal ");
    // DateTime dt2 = DateTime.now();
    // DateTime dt2 = DateTime.parse("2018-09-12");
    Duration diff = dt4!.difference(dt2);
    print(diff);

    // DateTime date1 = DateTime.parse(item.updatedAt);
    // DateTime date2 = DateTime.now();
    // var outputFormat = intl.DateFormat('dd/MM/yyyy');
    // var masaAkhir = outputFormat.format(dt4);
    // var tglSewa = outputFormat.format(dt5!);
    // print(otredit);
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
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          height: 120.0,
                          width: 200.0,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0),
                                  bottomLeft: Radius.circular(7.0),
                                  bottomRight: Radius.circular(7.0)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "https://www.kliknss.co.id/images/logo202001.png"),
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
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.text!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "Sans",
                          // fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lastdate,
                          style: const TextStyle(
                            fontSize: 12,
                            // color: Colors.white,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "selengkapnya",
                          style: TextStyle(
                              color: CustomColor.primaryRedColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
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
