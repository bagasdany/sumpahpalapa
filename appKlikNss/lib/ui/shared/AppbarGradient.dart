import 'dart:async';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';
import 'package:mobileapps/ui/component/lokasi_component.dart';
import 'package:mobileapps/ui/shared/search_white.dart';
import 'package:mobileapps/ui/shared/white.dart';
import 'package:mobileapps/ui/views/home/home_viewmodel.dart';
import 'package:mobileapps/ui/views/home/widget/location_view.dart';
import 'package:mobileapps/ui/views/login/login_view.dart';
import 'package:mobileapps/ui/views/sign_in/signin_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import '../../application/app/contants/custom_color.dart';
import '../../infrastructure/database/shared_prefs.dart';
import '../views/home/home_view.dart';
import '../views/home/search_view.dart';
import '../views/login/login_viewmodel.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient>
    with TickerProviderStateMixin {
  String CountNotice = "4";
  Position? currentPosition;
  String countryValue = "";

  String stateValue = "";
  String cityValue = "";
  String address = "";
  String lokasi = "";
  ScrollController _controller = ScrollController();
  final _sharedPrefs = SharedPrefs();
  final userLocation = (SharedPreferencesKeys.userLocation);
  final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    print("Extent after: $extentAfter");
  }

  AnimationController? _ColorAnimationController;
  AnimationController? _TextAnimationController;
  Animation? _colorTween, _iconColorTween;
  Animation<Offset>? _transTween;

  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Color(0xFFee4c4f))
        .animate(_ColorAnimationController!);
    _iconColorTween = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(_ColorAnimationController!);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController!);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController!.animateTo(scrollInfo.metrics.pixels / 350);

      _TextAnimationController!
          .animateTo((scrollInfo.metrics.pixels - 350) / 50);
      return true;
    } else {
      return false;
    }
  }

  /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    final userID = SharedPrefs().get(SharedPreferencesKeys.customerId);
    print("USER ID  ${userID}");

    /// Create responsive height and padding
    // GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    // final MediaQueryData media = MediaQuery.of(context);
    // final double statusBarHeight = MediaQuery.of(context).padding.top;

// resizeToAvoidBottomInset: false,
    // backgroundColor: Colors.transparent,
    // appBar: PreferredSize(
    //   preferredSize: Size.fromHeight(80.0),
    //   child: AppBar(
    //     backgroundColor: transparentColor,
    //     shadowColor: transparentColor,
    //     // automaticallyImplyLeading: false, // hides leading widget
    //     flexibleSpace: AppbarGradient(),
    //   ),
    // ),
    // extendBodyBehindAppBar: true,
    // backgroundColor: Color(0x44000000),

    /// Create component in appbar
    ///
    final ScrollController _homeController = new ScrollController();
    return SizedBox(
      height: 53,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: marginlvl1),
            //       decoration: ShapeDecoration(
            // color: Colors.white,
            // shape: Border.all(
            //   color: Colors.red,
            //   width: 8.0,
            // ) + Border.all(
            //   color: Colors.green,
            //   width: 8.0,
            // ) + Border.all(
            //   color: Colors.blue,
            //   width: 8.0,
            // ),
            // ),
            // color: CustomColor.primaryRedColor,
            // margin: EdgeInsets.only(right: 30),
            // padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColor.transparentColor,

              /// gradient in appbar
              // gradient: LinearGradient(
              //     colors: [
              //       const Color(0xFFA3BDED),
              //       const Color(0xFF6991C7),
              //     ],
              //     begin: const FractionalOffset(0.0, 0.0),
              //     end: const FractionalOffset(1.0, 0.0),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// if user click shape white in appbar navigate to search layout
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SearchView(),

                        /// transtation duration in animation
                        transitionDuration: const Duration(milliseconds: 750),

                        /// animation route to search layout
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));
                  },

                  /// Create shape background white in appbar (background treva shop text)
                  child: Container(
                    margin: EdgeInsets.only(left: marginlvl1),
                    height: marginlvl4,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        shape: BoxShape.rectangle),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // const Padding(padding: EdgeInsets.only(left: 10.0)),
                        // Image.asset(
                        //   "assets/img/search2.png",
                        //   height: 22.0,
                        // ),
                        const Padding(
                            padding: EdgeInsets.only(
                          left: 10.0,
                        )),
                        const Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            ('Cari di KlikNSS'),
                            style: TextStyle(
                                // fontFamily: "Popins",
                                color: Color.fromARGB(31, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 0.0,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Icon chat (if user click navigate to chat layout)
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => new chat()));
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: CustomColor.primaryWhiteColor,
                    child: Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                  ),
                ),

                /// Icon notification (if user click navigate to notification layout)
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => new notification()));
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    child: Stack(
                      alignment: const AlignmentDirectional(3.0, -2.0),
                      children: <Widget>[
                        const Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                        CircleAvatar(
                          radius: 8.6,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            CountNotice,
                            style: const TextStyle(
                                fontSize: 13.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    userID == null
                        ? Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const LoginView()))
                        : "";
                  },
                  child: const CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
