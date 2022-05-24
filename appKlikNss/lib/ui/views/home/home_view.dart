import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:mobileapps/temp_EMIL/form_m2w.dart';
import 'package:mobileapps/ui/component/brand_component.dart';
import 'package:mobileapps/ui/component/lokasi_component.dart';
import 'package:mobileapps/ui/component/shimmer_sm.dart';
import 'package:mobileapps/ui/views/home/widget/location_view.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/contants/shared_preferences_key.dart';
import '../../../application/models/home/CategoryItem.dart';
import '../../../application/models/home/category_icon_model.dart';
import '../../../temp_EMIL/listing_m2w.dart';
import '../../../infrastructure/database/shared_prefs.dart';
import '../../component/article_component.dart';
import '../../component/categoryicon_component.dart';
import '../../component/motor_component.dart';
import '../../component/pembiayaan_component.dart';
import '../../component/shimmer.dart';
import '../../component/sparepart_component.dart';
import '../../shared/AppbarGradient.dart';
import '../../shared/bottom_navigation.dart';
import '../../shared/search_bar.dart';
import 'home_viewmodel.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel> {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      locator<HomeViewModel>();

  void main() {
    // Add these 2 lines
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, //
    ]);

    // Then call runApp() as normal
    runApp(const HomeView());
  }

  @override
  bool get disposeViewModel => false;

  @override
  bool get inititaliseSpecialViewModelIsOnce => true;

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialise();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double size = mediaQueryData.size.height;
    int _selectIndex = 0;
    bool pressed = false;
    final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);
    bool isAppbarCollapsing = false;
    final ScrollController _homeController = new ScrollController();

    bool loadImage = true;
    List<String> data = [
      'sm : https://www.kliknss.co.id/images/ff6e1434093b868004aa2f8537860749.png,',
      'sm : https://www.kliknss.co.id/images/ff6e1434093b868004aa2f8537860749.png,',
      'sm : https://www.kliknss.co.id/images/ff6e1434093b868004aa2f8537860749.png,'
    ];

    double xOffset = 0;
    Offset offset = Offset.zero;
    double yOffset = 0;
    List<Widget>? nullableWidgets = [];

    const sm = "sm :";
    const koma = ",";
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    // print("section 1 ${viewModel.homeEntityModel!.sections![0].type}");

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit KlikNss App?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // <-- SEE HERE
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Widget renderImage(String url) {
      final banner =
          "sm: https://www.kliknss.co.id/images/ff6e1434093b868004aa2f8537860749.png,";
      if (viewModel.homeEntityModel == null) {
        final banner =
            "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png";
      } else {
        final banner = viewModel
                .homeEntityModel!.banners![0].imageUrl!.isNotEmpty
            ? viewModel.homeEntityModel!.banners![0]
            : "sm: https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png,";
      }

      // const awalan =
      final awalan2 = url.split("").elementAt(0);
      // const awalan = 'h';
      final awalIndex = url.indexOf(awalan2);
      final akhirIndex = url.indexOf(koma, awalIndex + awalan2.length);
      final imageUrl = url.substring(0, akhirIndex);
      final image = "${imageUrl.toString()}";
      // print("gambar link  ${imageUrl}");

      return Stack(
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              onTap: () {
                // handlefotoAset(widget.aset);
              },
              child: Container(
                margin: EdgeInsets.all(0),
                child: InteractiveViewer(
                  // transformationController: transController,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(30.0),
                        //     topRight: Radius.circular(7.0),
                        //     bottomLeft: Radius.circular(7.0),
                        //     bottomRight: Radius.circular(30.0)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      // Image.network(imageUrl);
      //rasido
    }

    Widget loadingShimmer(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            loadingMenuItemDiscountCard(),
        itemCount: viewModel.homeEntityModel != null
            ? viewModel.homeEntityModel!.sections!.length
            : 5,
      );
    }

    Widget itemcategory(BuildContext context) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => shimmerIcon(),
        itemCount: viewModel.homeEntityModel != null
            ? viewModel.homeEntityModel!.sections!.length
            : 5,
      );
    }

    Widget _loadingShimmer(BuildContext context) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            loadingMenuItemDiscountCard(),
        itemCount: newItems.length,
      );
    }

    Widget carousel() {
      return CarouselSlider(
          options: CarouselOptions(
            height: 300.0,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            // onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          items: viewModel.homeEntityModel != null
              ? viewModel.homeEntityModel!.banners!
                  .asMap()
                  .map((key, value) => MapEntry(key, Builder(
                        builder: (BuildContext context) {
                          return renderImage(viewModel
                              .homeEntityModel!.banners![key].imageUrl
                              .toString());
                        },
                      )))
                  .values
                  .toList()
              : nullableWidgets);
    }

    Widget categoryIconList() {
      return Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 100,
              width: 30,
              child: viewModel.isBusy || (viewModel.homeEntityModel == null)
                  ? loadingShimmer(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          viewModel.homeEntityModel!.categories!.isNotEmpty
                              ? iconItem(viewModel.homeEntityModel!)
                              : Container(),
                      itemCount:
                          viewModel.homeEntityModel!.categories!.isNotEmpty
                              ? viewModel.homeEntityModel!.categories!.length
                              : 10),
            ),
          )
        ],
      );
    }

    Widget listlokasi() {
      return Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  ('Lokasi'),
                  style: TextStyle(
                      fontFamily: "Gotik", fontSize: 18, color: Colors.black),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(right: 2, left: 5, top: 10),
                  height: 215.0,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) =>
                          viewModel.getlokasiEntityModel != null
                              ? viewModel.getlokasiEntityModel!.provinces!
                                      .isNotEmpty
                                  ? Column(
                                      children: [
                                        Text(viewModel.getlokasiEntityModel ==
                                                null
                                            ? viewModel.getlokasiEntityModel!
                                                .provinces![index].alias
                                                .toString()
                                            : ""),
                                        lokasiItem(viewModel
                                            .getlokasiEntityModel!
                                            .provinces![index]
                                            .cities![index]),
                                      ],
                                    )
                                  : Container()
                              : Container(),

                      //  getlokasi!.recommendationss != null
                      //                                 ? response!.recommendationss!.sections!
                      //                                         .isNotEmpty
                      //                                     ? RekomendasiItemMotortext(response!
                      //                                         .recommendationss!
                      //                                         .sections![0]
                      //                                         .items![index])
                      //                                     : Container()
                      //                                 : Container(),

                      itemCount: viewModel.getlokasiEntityModel != null
                          ? viewModel
                                  .getlokasiEntityModel!.provinces!.isNotEmpty
                              ? viewModel
                                  .getlokasiEntityModel!.provinces!.length
                              : 10
                          : 10),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget motorSection() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 25, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                viewModel.homeEntityModel!.sections![0].type == "HMCThumbnails"
                    ? Text(
                        viewModel.homeEntityModel!.sections![0].title
                            .toString(),
                        style: TextStyle(fontSize: 18, fontWeight: bold),
                        textAlign: TextAlign.left,
                      )
                    : viewModel.homeEntityModel!.sections![1].type ==
                            "HMCThumbnails"
                        ? Text(
                            viewModel.homeEntityModel!.sections![1].title
                                .toString(),
                            style: TextStyle(fontSize: 18, fontWeight: bold),
                            textAlign: TextAlign.left,
                          )
                        : viewModel.homeEntityModel!.sections![2].type ==
                                "HMCThumbnails"
                            ? Text(
                                viewModel.homeEntityModel!.sections![2].title
                                    .toString(),
                                style:
                                    TextStyle(fontSize: 18, fontWeight: bold),
                                textAlign: TextAlign.left,
                              )
                            : viewModel.homeEntityModel!.sections![3].type ==
                                    "HMCThumbnails"
                                ? Text(
                                    viewModel
                                        .homeEntityModel!.sections![3].title
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: bold),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(""),
                viewModel.homeEntityModel!.sections![0].type == "HMCThumbnails"
                    ? Text(
                        viewModel.homeEntityModel!.sections![0].linkText
                            .toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: CustomColor.primaryRedColor,
                            fontWeight: bold),
                        textAlign: TextAlign.left,
                      )
                    : viewModel.homeEntityModel!.sections![1].type ==
                            "HMCThumbnails"
                        ? Text(
                            viewModel.homeEntityModel!.sections![1].linkText
                                .toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.primaryRedColor,
                                fontWeight: bold),
                            textAlign: TextAlign.left,
                          )
                        : viewModel.homeEntityModel!.sections![2].type ==
                                "HMCThumbnails"
                            ? Text(
                                viewModel.homeEntityModel!.sections![2].linkText
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: CustomColor.primaryRedColor,
                                    fontWeight: bold),
                                textAlign: TextAlign.left,
                              )
                            : viewModel.homeEntityModel!.sections![3].type ==
                                    "HMCThumbnails"
                                ? Text(
                                    viewModel
                                        .homeEntityModel!.sections![3].linkText
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: CustomColor.primaryRedColor,
                                        fontWeight: bold),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(""),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: CustomColor.primaryWhiteColor,
              margin: EdgeInsets.only(right: 0.0),
              height: 300.0,
              child: viewModel.isBusy || (viewModel.homeEntityModel == null)
                  ? loadingShimmer(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (viewModel.homeEntityModel!.sections![0].type ==
                            "HMCThumbnails") {
                          return Container(
                            child: Column(
                              children: [
                                motorItem(viewModel.homeEntityModel!
                                    .sections![0].items![index]),
                              ],
                            ),
                          );
                        } else if (viewModel
                                .homeEntityModel!.sections![1].type ==
                            "HMCThumbnails") {
                          return motorItem(viewModel
                              .homeEntityModel!.sections![1].items![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![2].type ==
                            "HMCThumbnails") {
                          return motorItem(viewModel
                              .homeEntityModel!.sections![2].items![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![3].type ==
                            "HMCThumbnails") {
                          return motorItem(viewModel
                              .homeEntityModel!.sections![3].items![index]);
                        } else {
                          return Container();
                        }
                      },
                      // =>
                      // viewModel
                      //         .homeEntityModel!.sections!.isNotEmpty
                      //     ? motorItem(
                      //         viewModel.homeEntityModel!.sections![0].items![index])
                      //     : Container(),
                      itemCount: viewModel.homeEntityModel!.sections![0].type ==
                              "HMCThumbnails"
                          ? viewModel
                              .homeEntityModel!.sections![0].items!.length
                          : viewModel.homeEntityModel!.sections![1].type ==
                                  "HMCThumbnails"
                              ? viewModel
                                  .homeEntityModel!.sections![1].items!.length
                              : viewModel.homeEntityModel!.sections![2].type ==
                                      "HMCThumbnails"
                                  ? viewModel.homeEntityModel!.sections![2]
                                      .items!.length
                                  : viewModel.homeEntityModel!.sections![3]
                                              .type ==
                                          "HMCThumbnails"
                                      ? viewModel.homeEntityModel!.sections![3]
                                          .items!.length
                                      : 10),
            ),
          ),
        ],
      );
    }

    Widget pembiayaanSection2() {
      return viewModel.isBusy || (viewModel.homeEntityModel == null)
          ? loadingShimmer(context)
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // scrollDirection:
              //     viewModel.homeEntityModel!.sections![1].cols! == 2
              //         ? Axis.vertical
              //         : viewModel.homeEntityModel!.sections![1].cols! == 1
              //             ? Axis.horizontal
              //             : Axis.vertical,
              itemBuilder: (context, int index)
                  // {
                  //   if (viewModel.homeEntityModel!.sections!.isNotEmpty) {
                  //     return pembiayaanItem(
                  //         viewModel.homeEntityModel!.sections![index]
                  //             .items![index],
                  //         viewModel.homeEntityModel!);
                  //   }
                  //   else {
                  //     return
                  //   }
                  // }
                  =>
                  viewModel.homeEntityModel != null
                      ? viewModel.homeEntityModel!.sections![index].type ==
                                  "M2" &&
                              viewModel
                                      .homeEntityModel!.sections![index].cols ==
                                  2
                          ? Container(
                              color: CustomColor.primaryWhiteColor,
                              margin: EdgeInsets.only(top: 30, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Text(
                                        viewModel.homeEntityModel!
                                            .sections![index].title
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  pembiayaanItem(
                                      viewModel.homeEntityModel!
                                          .sections![index].items![0],
                                      viewModel.homeEntityModel!),
                                  pembiayaanItem(
                                      viewModel.homeEntityModel!
                                          .sections![index].items![1],
                                      viewModel.homeEntityModel!),
                                ],
                              ),
                            )
                          : viewModel.homeEntityModel!.sections![index].type ==
                                      "M2" &&
                                  viewModel.homeEntityModel!.sections![index]
                                          .cols ==
                                      1
                              ? Container(
                                  color: CustomColor.primaryWhiteColor,
                                  margin: EdgeInsets.only(top: 20, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Text(
                                            viewModel.homeEntityModel!
                                                .sections![index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18, fontWeight: bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          pembiayaanItem2(
                                              viewModel.homeEntityModel!
                                                  .sections![index].items![0],
                                              viewModel.homeEntityModel!),
                                          pembiayaanItem2(
                                              viewModel.homeEntityModel!
                                                  .sections![index].items![1],
                                              viewModel.homeEntityModel!),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                      : Container(),
              itemCount: 2);

      // viewModel.homeEntityModel != null
      //                   ? ListView.builder(
      //                       shrinkWrap: true,
      //                       itemCount:
      //                           viewModel.homeEntityModel!.sections!.length,
      //                       itemBuilder: ((context, index) {
      //                         if (viewModel
      //                                 .homeEntityModel!.sections![index].type ==
      //                             "HMCThumbnails") {
      //                           return motorSection();
      //                         } else if (viewModel
      //                                 .homeEntityModel!.sections![index].type ==
      //                             "SparepartThumbnailsWithBrand") {
      //                           return sparepartSection3();
      //                         } else if (viewModel
      //                                 .homeEntityModel!.sections![index].type ==
      //                             "M2") {
      //                           return pembiayaanSection2();
      //                         } else if (viewModel
      //                                 .homeEntityModel!.sections![index].type ==
      //                             "ArticleThumbnails") {
      //                           return articleSection4();
      //                         } else {
      //                           return Container();
      //                         }
      //                       }))
      //                   : loadingShimmer(context),
    }

    Widget sparepartSection3() {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 30, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                viewModel.homeEntityModel!.sections![0].type ==
                        "SparepartThumbnailsWithBrand"
                    ? Text(
                        viewModel.homeEntityModel!.sections![0].title
                            .toString(),
                        style: TextStyle(fontSize: 18, fontWeight: bold),
                        textAlign: TextAlign.left,
                      )
                    : viewModel.homeEntityModel!.sections![1].type ==
                            "SparepartThumbnailsWithBrand"
                        ? Text(
                            viewModel.homeEntityModel!.sections![1].title
                                .toString(),
                            style: TextStyle(fontSize: 18, fontWeight: bold),
                            textAlign: TextAlign.left,
                          )
                        : viewModel.homeEntityModel!.sections![2].type ==
                                "SparepartThumbnailsWithBrand"
                            ? Text(
                                viewModel.homeEntityModel!.sections![2].title
                                    .toString(),
                                style:
                                    TextStyle(fontSize: 18, fontWeight: bold),
                                textAlign: TextAlign.left,
                              )
                            : viewModel.homeEntityModel!.sections![3].type ==
                                    "SparepartThumbnailsWithBrand"
                                ? Text(
                                    viewModel
                                        .homeEntityModel!.sections![3].title
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: bold),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(""),
                viewModel.homeEntityModel!.sections![0].type ==
                        "SparepartThumbnailsWithBrand"
                    ? Text(
                        viewModel.homeEntityModel!.sections![0].linkText
                            .toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: CustomColor.primaryRedColor,
                            fontWeight: bold),
                        textAlign: TextAlign.left,
                      )
                    : viewModel.homeEntityModel!.sections![1].type ==
                            "SparepartThumbnailsWithBrand"
                        ? Text(
                            viewModel.homeEntityModel!.sections![1].linkText
                                .toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: CustomColor.primaryRedColor,
                                fontWeight: bold),
                            textAlign: TextAlign.left,
                          )
                        : viewModel.homeEntityModel!.sections![2].type ==
                                "SparepartThumbnailsWithBrand"
                            ? Text(
                                viewModel.homeEntityModel!.sections![2].linkText
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: CustomColor.primaryRedColor,
                                    fontWeight: bold),
                                textAlign: TextAlign.left,
                              )
                            : viewModel.homeEntityModel!.sections![3].type ==
                                    "SparepartThumbnailsWithBrand"
                                ? Text(
                                    viewModel
                                        .homeEntityModel!.sections![3].linkText
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: CustomColor.primaryRedColor,
                                        fontWeight: bold),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(""),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: CustomColor.primaryWhiteColor,
              margin: EdgeInsets.only(right: 10.0, top: 10),
              height: 65.0,
              child: viewModel.isBusy || (viewModel.homeEntityModel == null)
                  ? loadingShimmer(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (viewModel.homeEntityModel!.sections![0].type ==
                            "SparepartThumbnailsWithBrand") {
                          return brandItem(viewModel
                              .homeEntityModel!.sections![0].brands![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![1].type ==
                            "SparepartThumbnailsWithBrand") {
                          return brandItem(viewModel
                              .homeEntityModel!.sections![1].brands![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![2].type ==
                            "SparepartThumbnailsWithBrand") {
                          return brandItem(viewModel
                              .homeEntityModel!.sections![2].brands![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![3].type ==
                            "SparepartThumbnailsWithBrand") {
                          return brandItem(viewModel
                              .homeEntityModel!.sections![3].brands![index]);
                        } else {
                          return Container();
                        }
                      },
                      //  =>
                      //     viewModel.homeEntityModel != null
                      //         ? viewModel.homeEntityModel!.sections!.isNotEmpty
                      // ? brandItem(viewModel.homeEntityModel!
                      //     .sections![2].brands![index])
                      //             : Container()
                      //         : Container(),
                      itemCount: viewModel.homeEntityModel!.sections![0].type ==
                              "SparepartThumbnailsWithBrand"
                          ? viewModel
                              .homeEntityModel!.sections![0].brands!.length
                          : viewModel.homeEntityModel!.sections![1].type ==
                                  "SparepartThumbnailsWithBrand"
                              ? viewModel
                                  .homeEntityModel!.sections![1].brands!.length
                              : viewModel.homeEntityModel!.sections![2].type ==
                                      "SparepartThumbnailsWithBrand"
                                  ? viewModel.homeEntityModel!.sections![2]
                                      .brands!.length
                                  : viewModel.homeEntityModel!.sections![3]
                                              .type ==
                                          "SparepartThumbnailsWithBrand"
                                      ? viewModel.homeEntityModel!.sections![3]
                                          .brands!.length
                                      : 10
                      // viewModel.homeEntityModel != null
                      //     ? viewModel.homeEntityModel!.sections!.isNotEmpty
                      //         ? viewModel
                      //             .homeEntityModel!.sections![2].brands!.length
                      //         : 10
                      //     : 5
                      ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 10.0, top: 5),
              height: 350.0,
              color: CustomColor.primaryWhiteColor,

              ///viewModel.homeEntityModel!.sections![0].type
              child: viewModel.isBusy || (viewModel.homeEntityModel == null)
                  ? loadingShimmer(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          viewModel.homeEntityModel != null
                              ? viewModel.homeEntityModel!.sections!.isNotEmpty
                                  ? sparepartItem(viewModel.homeEntityModel!
                                      .sections![2].items![index])
                                  : Container()
                              : Container(),
                      itemCount: viewModel.homeEntityModel != null
                          ? viewModel.homeEntityModel!.sections!.isNotEmpty
                              ? viewModel
                                  .homeEntityModel!.sections![2].items!.length
                              : 10
                          : 5),
            ),
          )
        ],
      );
    }

    Widget articleSection4() {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                right: 10.0, left: 10.0, top: 20.0, bottom: 10),
            child: Container(
              color: CustomColor.backgroundGrayColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.sections![3].type
                            .toString()
                        : '',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryBlackColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new BottomNavigation()));
                    },
                    child: Text(
                      viewModel.homeEntityModel != null
                          ? viewModel.homeEntityModel!.sections![3].linkText
                              .toString()
                          : '',
                      style: TextStyle(
                          fontSize: 14.0, color: CustomColor.primaryRedColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 275.0,
              color: CustomColor.primaryWhiteColor,
              child: viewModel.isBusy || (viewModel.homeEntityModel == null)
                  ? loadingShimmer(context)
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (viewModel.homeEntityModel!.sections![0].type ==
                            "ArticleThumbnails") {
                          return artikelItem(viewModel
                              .homeEntityModel!.sections![0].items![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![1].type ==
                            "ArticleThumbnails") {
                          return artikelItem(viewModel
                              .homeEntityModel!.sections![1].items![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![2].type ==
                            "ArticleThumbnails") {
                          return artikelItem(viewModel
                              .homeEntityModel!.sections![2].items![index]);
                        } else if (viewModel
                                .homeEntityModel!.sections![3].type ==
                            "ArticleThumbnails") {
                          return artikelItem(viewModel
                              .homeEntityModel!.sections![3].items![index]);
                        } else {
                          return Container();
                        }
                      },
                      // =>
                      //     viewModel.homeEntityModel != null
                      //         ? viewModel.homeEntityModel!.sections!.isNotEmpty
                      // ? artikelItem(viewModel.homeEntityModel!
                      //     .sections![3].items![index])
                      //             : Container()
                      //         : Container(),
                      itemCount: viewModel.homeEntityModel!.sections![0].type ==
                              "ArticleThumbnails"
                          ? viewModel
                              .homeEntityModel!.sections![0].items!.length
                          : viewModel.homeEntityModel!.sections![1].type ==
                                  "ArticleThumbnails"
                              ? viewModel
                                  .homeEntityModel!.sections![1].items!.length
                              : viewModel.homeEntityModel!.sections![2].type ==
                                      "ArticleThumbnails"
                                  ? viewModel.homeEntityModel!.sections![2]
                                      .items!.length
                                  : viewModel.homeEntityModel!.sections![3]
                                              .type ==
                                          "ArticleThumbnails"
                                      ? viewModel.homeEntityModel!.sections![3]
                                          .items!.length
                                      : 10
                      // viewModel.homeEntityModel != null
                      //     ? viewModel.homeEntityModel!.sections!.isNotEmpty
                      //         ? viewModel
                      //             .homeEntityModel!.sections![3].items!.length
                      //         : 10
                      //     : 5
                      ),
            ),
          )
        ],
      );
    }

    Widget categoryIcon() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 0.0),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Get class CategoryIconValue
            ///
            viewModel.isBusy || (viewModel.homeEntityModel == null)
                ? shimmerIcon()
                : CategoryIconValue(
                    // viewModel.isBusy || (viewModel.homeEntityModel == null)
                    //     ? loadingShimmer(context)
                    //     :

                    icon1: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![0].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![0].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon2: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![1].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![1].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    tap2: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => M2wForm()));
                    },
                    icon3: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![2].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![2].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon4: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![3].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![3].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon5: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![4].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![4].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon6: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![5].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![5].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon7: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![6].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![6].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    icon8: viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![7].imageUrl!
                                .isEmpty
                            ? "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png"
                            : viewModel
                                .homeEntityModel!.categories![7].imageUrl!
                        : "https://www.ar.co.th/asset/upload/arg/2018/Jul/error-3060993_640.png",
                    title1: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![0].text
                        : ""),
                    title2: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![1].text
                        : ""),
                    title3: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![2].text
                        : ""),
                    title4: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![3].text
                        : ""),
                    title5: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![4].text
                        : ""),
                    title6: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![5].text
                        : ""),
                    title7: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![6].text
                        : ""),
                    title8: (viewModel.homeEntityModel != null
                        ? viewModel.homeEntityModel!.categories![7].text
                        : ""),
                  ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
          ],
        ),
      );
    }

    _onStartScroll(ScrollMetrics metrics) {
      print("Scroll Start");
    }

    _onUpdateScroll(ScrollMetrics metrics) {
      print("Scroll Update");
    }

    _onEndScroll(ScrollMetrics metrics) {
      print("Scroll End");
    }

    bool change = false;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: [
                    //  edge: ScrollEdge.end,
                    //                       edgeOffset: 400,
                    //                       continuous: true,
                    //                       debounce: const Duration(milliseconds: 500),
                    //                       dispatch: true,
                    //                       listener: () {
                    //                         print('listener called');
                    //                       },
                    SingleChildScrollView(
                      child: viewModel.homeEntityModel != null
                          ? carousel()
                          : shimmerIconbanner(),
                    ),
                    NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                          _onStartScroll(scrollNotification.metrics);
                        } else if (scrollNotification
                            is ScrollUpdateNotification) {
                          _onUpdateScroll(scrollNotification.metrics);
                        } else if (scrollNotification
                            is ScrollEndNotification) {
                          _onEndScroll(scrollNotification.metrics);
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children:

                              ///uncoment
                              <Widget>[
                            categoryIcon(),
                            viewModel.homeEntityModel != null
                                ? ScrollEdgeListener(
                                    edge: ScrollEdge.end,
                                    edgeOffset: 400,
                                    continuous: true,
                                    debounce: const Duration(milliseconds: 500),
                                    dispatch: true,
                                    listener: () {
                                      print('listener called');
                                    },
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: viewModel
                                            .homeEntityModel!.sections!.length,
                                        itemBuilder: ((context, index) {
                                          if (viewModel.homeEntityModel!
                                                  .sections![index].type ==
                                              "HMCThumbnails") {
                                            return motorSection();
                                          } else if (viewModel.homeEntityModel!
                                                  .sections![index].type ==
                                              "SparepartThumbnailsWithBrand") {
                                            return sparepartSection3();
                                          } else if (viewModel.homeEntityModel!
                                                  .sections![index].type ==
                                              "M2") {
                                            return pembiayaanSection2();
                                          } else if (viewModel.homeEntityModel!
                                                  .sections![index].type ==
                                              "ArticleThumbnails") {
                                            return articleSection4();
                                          } else {
                                            return Container();
                                          }
                                        })),
                                  )
                                : loadingShimmer(context),
                            SizedBox(
                              height: 400,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //     return StickyHeader(
              // header: Container(
              //   height: 50.0,
              //   color: Colors.blueGrey[700],
              //   padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   alignment: Alignment.centerLeft,
              //   child: Text('Header #$index',
              //     style: const TextStyle(color: Colors.white),
              //   ),
              // ),
              // SearchBar()
              Container(
                child: Column(
                  children: [
                    Container(child: AppbarGradient()),
                    viewModel.getlokasiEntityModel == null
                        ? Container()
                        : LocationViewWidget(
                            viewModel: HomeViewModel(),
                            listLocation: viewModel.getlokasiEntityModel!,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}
