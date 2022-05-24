import 'dart:async';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/ui/shared/search_white.dart';
import 'package:mobileapps/ui/shared/white.dart';
import 'package:mobileapps/ui/views/login/login_view.dart';
import 'package:mobileapps/ui/views/sign_in/signin_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../application/app/contants/custom_color.dart';
import '../../infrastructure/database/shared_prefs.dart';
import '../views/home/home_view.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  String CountNotice = "4";
  Position? currentPosition;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String lokasi = "";
  final _sharedPrefs = SharedPrefs();
  final userLocation = (SharedPreferencesKeys.userLocation);
  final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);

  Position? _position;
  String? currentAddress;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemarks = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentAddress = '${place.street}';
        final shared = _sharedPrefs.set(
            SharedPreferencesKeys.userLocation, currentAddress);

        // ,Kel. ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country},${place.isoCountryCode}';
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location not available");
      }
    } else {
      print("Location not available...");
    }
    return await Geolocator.getCurrentPosition();
  }

  /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    /// Create responsive height and padding
    // GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    // final MediaQueryData media = MediaQuery.of(context);
    // final double statusBarHeight = MediaQuery.of(context).padding.top;

    /// Create component in appbar
    return Column(
      children: [
        Container(
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
          height: MediaQuery.of(context).size.height * 0.07,
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
                      pageBuilder: (_, __, ___) => searchAppbar(),

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
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text(
                          ('Cari di KlikNSS'),
                          style: TextStyle(
                              // fontFamily: "Popins",
                              color: Colors.black12,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 0.0,
                              fontSize: 16),
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
                child: const CircleAvatar(
                  radius: 19,
                  backgroundColor: Colors.white,
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
                    alignment: const AlignmentDirectional(-3.0, -3.0),
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
                  // Navigator.of(context).push(PageRouteBuilder(
                  //     pageBuilder: (_, __, ___) => new chat()));
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
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 0, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                size: 20,
              ),
              // Text(
              //   "Lokasi",
              //   style: TextStyle(fontSize: 12),
              // ),
              // SizedBox(
              //   width: 2,
              // ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Positioned(
                                  // width: MediaQuery.of(context).size.width,
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: ElevatedButton(

                                              // child: Text("Lokasi"),
                                              style: ElevatedButton.styleFrom(
                                                primary: CustomColor
                                                    .primaryRedColor, // background
                                                onPrimary: CustomColor
                                                    .primaryWhiteColor, // foreground
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.location_on),
                                                  Text(
                                                    'Gunakan Lokasi saya',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .primaryWhiteColor,
                                                        fontWeight: bold,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              onPressed: () async {
                                                _getCurrentLocation;
                                                currentPosition =
                                                    await getPosition();
                                                getAddress(
                                                    currentPosition!.latitude,
                                                    currentPosition!.longitude);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeView()));
                                                // Navigator.pop(
                                                //     context,
                                                //     white(
                                                //       customerName: location,
                                                //     ));
                                              }),
                                        ),
                                        const Text(
                                          "atau",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          height: 300,
                                          child: Center(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: 600,
                                                child: Column(
                                                  children: [
                                                    ///Adding CSC Picker Widget in app
                                                    CSCPicker(
                                                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                                      showStates: true,

                                                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                                                      showCities: true,

                                                      ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                                      flagState: CountryFlag
                                                          .SHOW_IN_DROP_DOWN_ONLY,

                                                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                                      dropdownDecoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          30)),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              width: 1)),

                                                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                                      disabledDropdownDecoration:
                                                          BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      const Radius.circular(
                                                                          30)),
                                                              color: Colors.grey
                                                                  .shade300,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  width: 1)),

                                                      ///selected item style [OPTIONAL PARAMETER]
                                                      selectedItemStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),

                                                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                                      dropdownHeadingStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),

                                                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                                      dropdownItemStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),

                                                      ///Dialog box radius [OPTIONAL PARAMETER]
                                                      dropdownDialogRadius:
                                                          10.0,

                                                      ///Search bar radius [OPTIONAL PARAMETER]
                                                      searchBarRadius: 10.0,

                                                      ///triggers once country selected in dropdown
                                                      onCountryChanged:
                                                          (value) {
                                                        setState(() {
                                                          ///store value in country variable
                                                          countryValue = value;
                                                        });
                                                      },

                                                      ///triggers once state selected in dropdown
                                                      onStateChanged: (value) {
                                                        setState(() {
                                                          ///store value in state variable
                                                          stateValue =
                                                              value.toString();
                                                        });
                                                      },

                                                      ///triggers once city selected in dropdown
                                                      onCityChanged: (value) {
                                                        setState(() {
                                                          ///store value in city variable
                                                          cityValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),

                                                    ///print newly selected country state and city in Text Widget
                                                    TextButton(
                                                        onPressed: () async {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     new MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 BottomAppBar()));
                                                          // Navigator.of(context)
                                                          //     .pop(true);
                                                          SchedulerBinding
                                                              .instance!
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            lokasi = cityValue
                                                                .toString();

                                                            final address =
                                                                _sharedPrefs.set(
                                                                    SharedPreferencesKeys
                                                                        .userLocation,
                                                                    lokasi);
                                                            _sharedPrefs.set(
                                                                SharedPreferencesKeys
                                                                    .userLocation,
                                                                lokasi);
                                                            // add your code here.
                                                            // Navigator.push(
                                                            //     context,
                                                            //     new MaterialPageRoute(
                                                            //         builder:
                                                            //             (context) =>
                                                            //                 HomeView()));
                                                            // Navigator.pop(
                                                            //     context,
                                                            //     white(
                                                            //       customerName:
                                                            //           location,
                                                            //     ));
                                                            Navigator
                                                                .popAndPushNamed(
                                                                    context,
                                                                    '/bottom-navigation-bar');
                                                            // startAutoReload();
                                                          });
                                                          // Navigator.push(
                                                          //     context,
                                                          //     new MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 HomeView()));
                                                        },
                                                        child: const Text(
                                                            "Pilih Data")),

                                                    Text(address)
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // if (_currentPosition != null && currentAddress != null)
                                    //   Text(currentAddress, style: TextStyle(fontSize: 10.0))
                                  ],
                                ),
                                // Form(
                                //   // key: _formKey,
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: <Widget>[
                                //       Padding(
                                //         padding: EdgeInsets.all(8.0),
                                //         child: TextFormField(),
                                //       ),
                                //       Padding(
                                //         padding: EdgeInsets.all(8.0),
                                //         child: TextFormField(),
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: RaisedButton(
                                //           child: Text("Submit"),
                                //           onPressed: () {
                                //             // if (_formKey.currentState
                                //             //     .validate()) {
                                //             //   _formKey.currentState.save();
                                //             // }
                                //           },
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text(
                  "Lokasi",
                  style: TextStyle(fontSize: 12, fontWeight: medium),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shadowColor: CustomColor.transparentColor,
                  // fixedSize: const Size(50, 80),
                  minimumSize: const Size(20, 40),
                  primary: CustomColor.transparentColor, // background
                  onPrimary: CustomColor.primaryBlackColor, // foreground
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     TextButton(
              //         child: Text(
              //           'Get Location',
              //           style: Theme.of(context).textTheme.caption,
              //         ),
              //         onPressed: () async {
              //           _getCurrentLocation;
              //           currentPosition = await getPosition();
              //           getAddress(currentPosition!.latitude,
              //               currentPosition!.longitude);
              //         }),
              //     // if (_currentPosition != null && currentAddress != null)
              //     //   Text(currentAddress, style: TextStyle(fontSize: 10.0))

              //     currentAddress != null
              //         ? Text(currentAddress.toString())
              //         : Text('No Location Data'),
              //   ],
              // ),
              location != null
                  ? Text(
                      location.toString(),
                      style: TextStyle(fontSize: 14, fontWeight: bold),
                    )
                  : const Text('No Location Data'),
            ],
          ),
        ),
      ],
    );
  }
}
