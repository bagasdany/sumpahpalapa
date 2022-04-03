import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final splashData = [
    {
      "title": 'Fast, reliable and saves time',
      "image": "lib/assets/images/light_mode/image7.png"
    },
    {
      "title": "The World’s first platform",
      "image": "lib/assets/images/light_mode/image6.png"
    },
    {
      "title": "Live, eat and shopping",
      "image": "lib/assets/images/light_mode/image8.png"
    }
  ];

  AuthController authController = Get.put(AuthController());

  int _selectedIndex = 0;

  Widget _page(index) {
    return Container(
      width: 1.sw,
      height: 0.77.sh,
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: -12,
              child: Image(
                image: AssetImage(splashData[index]["image"]!),
                height: 0.7.sh,
                width: 1.sw,
                fit: BoxFit.fitHeight,
              )),
          Positioned(
            top: 12,
            left: 32,
            right: 32,
            child: Container(
              width: 0.75.sw,
              child: Text(
                "${splashData[index]["title"]}".tr,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp,
                    color: Colors.black,
                    letterSpacing: -2,
                    height: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(index) {
    return Container(
      width: 40,
      height: 4,
      margin: EdgeInsets.only(left: index == 0 ? 0 : 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: _selectedIndex == index
              ? Color.fromRGBO(69, 165, 36, 1)
              : Color.fromRGBO(233, 233, 230, 1)),
    );
  }

  Widget _indicator() {
    return Container(
      margin: EdgeInsets.only(left: 33, bottom: 32),
      width: 136,
      height: 4,
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: 3,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _dot(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Color.fromRGBO(19, 20, 21, 1)
            : Color.fromRGBO(243, 243, 240, 1),
        body: Container(
            width: 1.sw,
            height: 1.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 1.sw,
                    margin: EdgeInsets.only(top: 0.075.sh, right: 16),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Skip".tr,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          letterSpacing: -1,
                          color: Color.fromRGBO(136, 136, 126, 1)),
                    ),
                  ),
                  onTap: () {
                    authController.getUserInfoAndRedirect();
                  },
                ),
                Container(
                    width: 1.sw,
                    height: 0.76.sh,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return _page(index);
                      },
                      itemCount: splashData.length,
                      onPageChanged: (page) {
                        setState(() {
                          _selectedIndex = page;
                        });
                      },
                    )),
                _indicator(),
                Container(
                    width: 1.sw,
                    margin: EdgeInsets.only(left: 33),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Get.offAndToNamed("/signin");
                            },
                            child: SizedBox(
                              width: 0.5.sw - 60,
                              child: Text(
                                "Login".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                    fontFamily: 'Inter'),
                              ),
                            )),
                        Text(
                          "  ${"or".tr}  ",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.3,
                              fontFamily: 'Inter'),
                        ),
                        InkWell(
                            onTap: () {
                              Get.offAndToNamed("/signup");
                            },
                            child: SizedBox(
                              width: 0.5.sw - 60,
                              child: Text(
                                "Sign Up".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                    fontFamily: 'Inter'),
                              ),
                            ))
                      ],
                    ))
              ],
            )));
  }
}
