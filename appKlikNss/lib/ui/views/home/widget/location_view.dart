import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';

import '../../../../application/app/contants/custom_color.dart';
import '../../../../application/app/contants/shared_preferences_key.dart';
import '../../../../infrastructure/database/shared_prefs.dart';
import '../../login/login_viewmodel.dart';
import '../home_view.dart';
import '../home_viewmodel.dart';

class LocationViewWidget extends StatefulWidget {
  final HomeViewModel viewModel;
  final ResponseGetLokasiModel listLocation;

  const LocationViewWidget(
      {Key? key, required this.viewModel, required this.listLocation})
      : super(key: key);

  @override
  State<LocationViewWidget> createState() => _LocationViewWidgetState();
}

class _LocationViewWidgetState extends State<LocationViewWidget> {
  // List<Province>? semua = widget.listLocation.provinces;

  // late final ResponseGetLokasiModel listLocations;
  List<Province>? hasilpencarian = [];

  // void _filter(String keyword) async {
  //   List<Province>? hasilsementara = [];
  //   // List<dynamic> allLocations = widget.listLocation.provinces!;
  //   if (keyword.isEmpty) {
  //     // hasilsementara = hasilpencarian;
  //     setState(() {
  //       hasilpencarian = hasilsementara;
  //     });
  //   } else {
  //     setState(() {
  //       hasilsementara = hasilpencarian!
  //           .where((el) =>
  //               el.alias!.toLowerCase().startsWith(keyword.toLowerCase()))
  //           .toList();
  //     });
  //   }
  //   setState(() {
  //     hasilpencarian = hasilsementara;
  //   });
  // }
  void _filter(String query) {
    final suggestions = hasilpencarian!.where((hasil) {
      final suggestiontile = hasil.alias!.toLowerCase();
      final input = query.toLowerCase();

      return suggestiontile.contains(input);
    }).toList();
    setState(() => hasilpencarian = suggestions);
  }

  @override
  initState() {
    // at the beginning, all users are shown
    hasilpencarian = widget.listLocation.provinces;
    _filter;
    setState(() {
      hasilpencarian;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);

    return Container(
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
              // location
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      child: Column(
                        children: [
                          AlertDialog(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    const Icon(
                                                        Icons.location_on),
                                                    Text(
                                                      'Gunakan Lokasi saya',
                                                      style: TextStyle(
                                                          color: CustomColor
                                                              .primaryWhiteColor,
                                                          fontWeight: bold,
                                                          fontSize: 14),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  // _getCurrentLocation;
                                                  // currentPosition =
                                                  //     await getPosition();

                                                  // getAddress(
                                                  //     currentPosition!.latitude,
                                                  //     currentPosition!
                                                  //         .longitude);
                                                  LoginViewModel().lokasi();
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
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                top: marginlvl1),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              height: 50,
                                              child: TextField(
                                                scrollPadding:
                                                    EdgeInsets.only(top: 10),
                                                onChanged: (value) =>
                                                    _filter(value),
                                                // onP: _filter,
                                                // onTap: _filter,
                                                decoration: const InputDecoration(
                                                    labelText:
                                                        'Ketik nama Provinsi',
                                                    suffixIcon:
                                                        Icon(Icons.search)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            child: SingleChildScrollView(
                                                child: hasilpencarian != null
                                                    ? Column(
                                                        children:
                                                            hasilpencarian!
                                                                .map((e) =>
                                                                    Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 10),
                                                                            child:
                                                                                Text(
                                                                              e.name!,
                                                                              style: TextStyle(fontWeight: bold),
                                                                            ),
                                                                          ),
                                                                          ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: e.cities!.length,
                                                                              itemBuilder: ((context, index) => Container(
                                                                                      // key: ValueKey(hasilpencarian[index].id),
                                                                                      // margin: EdgeInsets.only(left: 20),
                                                                                      child: Container(
                                                                                    padding: EdgeInsets.all(10),
                                                                                    color: CustomColor.backgroundGrayColor,
                                                                                    margin: EdgeInsets.only(top: 5),
                                                                                    child: Text(
                                                                                      e.cities![index].alias!,
                                                                                      style: TextStyle(fontSize: 16),
                                                                                    ),
                                                                                  ))))
                                                                        ],
                                                                      ),
                                                                    ))
                                                                .toList())
                                                    : Container()),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     LoginViewModel().getprovinsi();
                                          //   },
                                          //   child: Container(
                                          //     width: 200,
                                          //     height: 200,
                                          //     child: Text("get Provinsi"),
                                          //   ),
                                          // ),
                                          // listlokasi(),
                                        ],
                                      ),
                                      // if (_currentPosition != null && currentAddress != null)
                                      //   Text(currentAddress, style: TextStyle(fontSize: 10.0))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
