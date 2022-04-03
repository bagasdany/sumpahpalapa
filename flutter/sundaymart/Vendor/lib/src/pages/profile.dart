import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/profile_item.dart';
import 'package:vendor/src/components/total_panel.dart';
import 'package:vendor/src/controllers/auth_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:vendor/src/models/user.dart';

class Profile extends GetView<AuthController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = controller.getUser();

    return Container(
      width: 1.sw,
      height: 1.sh,
      color: HexColor("#FFFFFF"),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Column(
          children: [
            SizedBox(
              width: 1.sw - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      const IconData(0xeb98, fontFamily: 'MIcon'),
                      color: HexColor("#000000"),
                      size: 24.sp,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(left: 4, right: 15),
                  decoration: BoxDecoration(
                      color: HexColor("#C4C4C4"),
                      border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.35),
                          width: 4),
                      borderRadius: BorderRadius.circular(30)),
                  child: user!.imageUrl != null && user.imageUrl!.length > 3
                      ? Container()
                      : Icon(
                          const IconData(0xf264, fontFamily: 'MIcon'),
                          color: HexColor("#ffffff"),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 1.sw - 110,
                      child: Text(
                        "${user.name} ${user.surname}",
                        style: TextStyle(
                            color: HexColor("#000000"),
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      user.role == 1 ? "Superadmin" : "Manager",
                      style: TextStyle(
                          color: HexColor("#88887E"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 0.5.sw,
                  height: 72,
                  child: CustomPaint(
                    painter: TotalPanel(),
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            margin: const EdgeInsets.only(right: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                color: HexColor("#ffffff").withOpacity(0.28),
                                borderRadius: BorderRadius.circular(27)),
                            child: Icon(
                              const IconData(0xef64, fontFamily: 'MIcon'),
                              color: HexColor("#ffffff"),
                              size: 28.sp,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Balance",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: HexColor("#ffffff"),
                                    fontSize: 13.sp,
                                    letterSpacing: -0.5),
                              ),
                              Text(
                                "${user.totalBalance}",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#ffffff"),
                                    fontSize: 20.sp,
                                    height: 1.2,
                                    letterSpacing: -0.5),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 0.174.sw,
                //   height: 0.174.sw,
                //   decoration: BoxDecoration(
                //       color: HexColor("#F1F1F1"),
                //       borderRadius: BorderRadius.circular(12)),
                // ),
                // Container(
                //   width: 0.174.sw,
                //   height: 0.174.sw,
                //   decoration: BoxDecoration(
                //       color: HexColor("#F1F1F1"),
                //       borderRadius: BorderRadius.circular(12)),
                // )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileItem(
              title: "Shops",
              onPress: () {
                Get.toNamed("/shops");
              },
              icon: const IconData(0xf116, fontFamily: 'MIcon'),
            ),
            ProfileItem(
              title: "Brands",
              onPress: () {
                Get.toNamed("/brands");
              },
              icon: const IconData(0xef28, fontFamily: 'MIcon'),
            ),
            ProfileItem(
              title: "Product categories",
              onPress: () {
                Get.toNamed("/categories");
              },
              icon: const IconData(0xed9e, fontFamily: 'MIcon'),
            ),
            ProfileItem(
              title: "Clients",
              onPress: () {
                controller.adminController.loadData.value = true;
                controller.adminController.getClients();
                Get.toNamed("/clients");
              },
              icon: const IconData(0xf254, fontFamily: 'MIcon'),
            ),
            ProfileItem(
              title: "Addresses",
              onPress: () {
                controller.adminController.loadData.value = true;
                controller.adminController.getAddresses();
                Get.toNamed("/address");
              },
              icon: const IconData(0xf266, fontFamily: 'MIcon'),
            ),
            // ProfileItem(
            //   title: "Coupons",
            //   onPress: () {},
            //   icon: const IconData(0xebec, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Banners",
            //   onPress: () {},
            //   icon: const IconData(0xee4b, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Notifications",
            //   onPress: () {},
            //   icon: const IconData(0xef9a, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Language",
            //   onPress: () {},
            //   icon: const IconData(0xedcf, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Users",
            //   onPress: () {},
            //   icon: const IconData(0xf10c, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "App settings",
            //   onPress: () {},
            //   icon: const IconData(0xf15a, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Page settings",
            //   onPress: () {},
            //   icon: const IconData(0xf0ec, fontFamily: 'MIcon'),
            // ),
            // ProfileItem(
            //   title: "Media",
            //   onPress: () {},
            //   icon: const IconData(0xeda5, fontFamily: 'MIcon'),
            // ),
            ProfileItem(
              title: "Log out",
              onPress: () {
                controller.logout();
              },
              icon: const IconData(0xeede, fontFamily: 'MIcon'),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
