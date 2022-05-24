import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:mobileapps/application/models/home/response_recomendationSearch_model.dart';
import 'package:mobileapps/ui/component/brand_component.dart';
import 'package:mobileapps/ui/component/resparepart_component.dart';
import 'package:mobileapps/ui/component/resultSearch_component.dart';
import 'package:mobileapps/ui/component/shimmer_sm.dart';
import 'package:mobileapps/ui/views/home/home_view.dart';
import 'package:mobileapps/ui/views/home/resultSearch_viewmodel.dart';
import 'package:mobileapps/ui/views/home/search_view.dart';
import 'package:mobileapps/ui/views/home/search_viewmodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/models/home/CategoryItem.dart';
import '../../../application/models/home/category_icon_model.dart';
import '../../component/article_component.dart';
import '../../component/categoryicon_component.dart';
import '../../component/motor_component.dart';
import '../../component/pembiayaan_component.dart';
import '../../component/pencarian_component.dart';
import '../../component/rekomendasi_motor_component.dart';
import '../../component/rekomendasi_sparepart.dart';
import '../../component/rekomendasi_text_component.dart';
import '../../component/remotorItem_component.dart';
import '../../component/resulttext_component.dart';
import '../../component/shimmer.dart';
import '../../component/sparepart_component.dart';
import '../../shared/AppbarGradient.dart';
import '../../shared/bottom_navigation.dart';
import '../../shared/search_bar.dart';
import 'home_viewmodel.dart';

class resultSearchViewText
    extends ViewModelBuilderWidget<resultSearchViewModel> {
  final String? kunci;
  final ResponseRecomendationModel? response;
  resultSearchViewText({Key? key, this.kunci, this.response}) : super(key: key);

  @override
  resultSearchViewModel viewModelBuilder(BuildContext context) =>
      locator<resultSearchViewModel>();

  @override
  bool get disposeViewModel => false;

  @override
  bool get inititaliseSpecialViewModelIsOnce => true;

  @override
  // void onViewModelReady(SearchViewModel viewModel) => viewModel.initialize();

  @override
  Widget builder(
      BuildContext context, resultSearchViewModel viewModel, Widget? child) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    Offset offset = Offset.zero;
    // print("kunci ${kunci}");
    // List<Widget>? nullableWidgets = [];
    print("response ${response}");
    const sm = "sm :";
    const koma = ",m";
    Widget loadingShimmer(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            loadingMenuItemDiscountCard(),
        itemCount:
            response != null ? response!.recommendationss!.sections!.length : 5,
      );
    }

    Widget rekomendasiMotor() {
      return Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  ('Rekomendasi'),
                  style: TextStyle(
                      fontFamily: "Gotik", fontSize: 18, color: Colors.black),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(right: 2, left: 5, top: 10),
                  height: 215.0,
                  child: viewModel.isBusy
                      ? loadingShimmer(context)
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) =>
                              response!.recommendationss != null
                                  ? response!.recommendationss!.sections!
                                          .isNotEmpty
                                      ? RekomendasiItemMotortext(response!
                                          .recommendationss!
                                          .sections![0]
                                          .items![index])
                                      : Container()
                                  : Container(),
                          itemCount: response != null
                              ? response!.recommendationss!.sections!.isNotEmpty
                                  ? response!.recommendationss!.sections![0]
                                      .items!.length
                                  : 10
                              : 10),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget rekomendasiSparepart() {
      return Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0, left: 10),
                  height: 235.0,
                  child: viewModel.isBusy || (response == null)
                      ? loadingShimmer(context)
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) =>
                              response != null
                                  ? response!.recommendationss!.sections!
                                          .isNotEmpty
                                      ? rekomendasiSparepartItemtext(response!
                                          .recommendationss!
                                          .sections![1]
                                          .items![index])
                                      : Container()
                                  : Container(),
                          itemCount: viewModel.resultModeltext != null
                              ? viewModel.resultModeltext!.recommendationss!
                                      .sections!.isNotEmpty
                                  ? viewModel.resultModeltext!.recommendationss!
                                      .sections![1].items!.length
                                  : 10
                              : 10),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget resultSearchtext() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  ('Hasil Pencarian'),
                  style: TextStyle(
                      fontFamily: "Gotik", fontSize: 18, color: Colors.black),
                ),
              ),
              response != null
                  ? response!.results == null || response!.results!.isEmpty
                      ? Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 30),
                              child: Center(
                                child: Text(
                                  ('Maaf,hasil tidak ditemukan,\n untuk pencarian diatas'),
                                  style: TextStyle(
                                      fontFamily: "Gotik",
                                      fontSize: 18,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            rekomendasiMotor(),
                            rekomendasiSparepart(),
                            // Text("data"),
                            // Padding(padding: EdgeInsets.only(top: 30)),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(
                                right: 10,
                              ),
                              // height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: viewModel.isBusy
                                  ? CircularProgressIndicator()
                                  : GridView.count(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: marginlvl1,
                                          vertical: marginlvl1),
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 17.0,
                                      childAspectRatio: 0.665,
                                      crossAxisCount: 2,
                                      primary: false,
                                      children: List.generate(
                                        response != null
                                            ? response!.results != null
                                                ? response!.results!.isNotEmpty
                                                    ? response!.results!.length
                                                    : 10
                                                : 10
                                            : 10,
                                        (index) => response != null
                                            ? response!.results != null
                                                ? response!.results!.isNotEmpty
                                                    ? ResultSearchitemtext(
                                                        response!
                                                            .results![index])
                                                    : Container(
                                                        child: Text(
                                                          "Maaf,hasil tidak ditemukan,\n untuk pencarian diatas",
                                                        ),
                                                      )
                                                : Container()
                                            : Container(),
                                      ),
                                    )

                              // ListView.builder(
                              //     scrollDirection: Axis.vertical,
                              //     itemBuilder: (BuildContext context, int index) =>
                              //         viewModel.resultModel!.results!.isNotEmpty
                              //             ? ResultSearchitem(
                              //                 viewModel.resultModel!.results![index])
                              //             : Container(),
                              //     itemCount: viewModel.resultModel!.results!.isNotEmpty
                              //         ? viewModel.resultModel!.results!.length
                              //         : 10),
                              ),
                        )
                  : const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 30),
                      child: Center(
                        child: Text(
                          ('Maaf,hasil tidak ditemukan,\n untuk pencarian diatas'),
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 18,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          ),
          // SingleChildScrollView(
          //   child: Container(
          //       margin: EdgeInsets.only(
          //         right: 10,
          //       ),
          //       // height: MediaQuery.of(context).size.height,
          //       width: MediaQuery.of(context).size.width,
          //       child: viewModel.isBusy
          //           ? loadingShimmer(context)
          //           : GridView.count(
          //               shrinkWrap: true,
          //               padding: EdgeInsets.symmetric(
          //                   horizontal: marginlvl1, vertical: marginlvl1),
          //               crossAxisSpacing: 10.0,
          //               mainAxisSpacing: 17.0,
          //               childAspectRatio: 0.665,
          //               crossAxisCount: 2,
          //               primary: false,
          //               children: List.generate(
          //                 viewModel.resultModeltext != null
          //                     ? viewModel.resultModeltext!.results != null
          //                         ? viewModel
          //                                 .resultModeltext!.results!.isNotEmpty
          //                             ? viewModel
          //                                 .resultModeltext!.results!.length
          //                             : 10
          //                         : 10
          //                     : 10,
          //                 (index) => viewModel.resultModeltext != null
          //                     ? viewModel.resultModeltext!.results != null
          //                         ? viewModel
          //                                 .resultModeltext!.results!.isNotEmpty
          //                             ? ResultSearchitemtext(viewModel
          //                                 .resultModeltext!.results![index])
          //                             : Container(
          //                                 child: Text(
          //                                   "Maaf,hasil tidak ditemukan,\n untuk pencarian diatas",
          //                                 ),
          //                               )
          //                         : Container()
          //                     : Container(),
          //               ),
          //             )

          //       // ListView.builder(
          //       //     scrollDirection: Axis.vertical,
          //       //     itemBuilder: (BuildContext context, int index) =>
          //       //         viewModel.resultModel!.results!.isNotEmpty
          //       //             ? ResultSearchitem(
          //       //                 viewModel.resultModel!.results![index])
          //       //             : Container(),
          //       //     itemCount: viewModel.resultModel!.results!.isNotEmpty
          //       //         ? viewModel.resultModel!.results!.length
          //       //         : 10),
          //       ),
          // ),
        ],
      );
    }

    Widget SearchBar() {
      return Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
            color: CustomColor.backgroundGrayColor,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: CustomColor.backgroundGrayColor,
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: CustomColor.primaryWhiteColor),
              child: TextFormField(
                controller: viewModel.searchController,
                onFieldSubmitted: (searchController) {
                  var searchkey = viewModel.searchController.text.toString();
                  viewModel.resultSearchApi(
                    searchkey,
                  );
                  // Navigator.pop(context, this._textController.text);
                },
                onChanged: (value) => viewModel.onChangeSearch(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, const HomeView());
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColor.primaryBlackColor,
                      size: 26.0,
                    ),
                  ),
                  hintText: kunci == null
                      ? ('Masukkan kata kunci pencarian...')
                      : kunci,
                  hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget renderImage(String url) {
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
                    height: MediaQuery.of(context).size.height * 0.29,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(30.0),
                        //     topRight: Radius.circular(7.0),
                        //     bottomLeft: Radius.circular(7.0),
                        //     bottomRight: Radius.circular(30.0)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(viewModel
                                .searchEntityModel!
                                .recommendations!
                                .sections![0]
                                .items![0]
                                .defaultImageUrl
                                .toString()),
                            fit: BoxFit.fitWidth)),
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle(statusBarColor: CustomColor.backgroundGrayColor),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Caliing a variable
                  // _textHello,
                  // AppbarGradient(),
                  SearchBar(),
                  resultSearchtext(),
                  // resultSearchtext(),
                  // viewModel.resultModel.results.
                  // rekomendasitext(),
                  // rekomendasiItem(),

                  // const Padding(
                  //     padding: const EdgeInsets.only(bottom: 30.0, top: 2.0))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}
