import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/OnBoardingModel.dart';
import 'package:mobileapps/ui/views/onboarding/onboarding_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final _navigationService = locator<NavigationService>();
  late PageController _pageController;
  late int idx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    idx = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = OnBoardingUtils.getItemSplashScreen();
    return WillPopScope(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _buildHeader(idx, items),
          child: Scaffold(
            body: SafeArea(
                child: Container(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 490.h,
                    child: PageView.builder(
                        controller: _pageController,
                        key: const Key('pageController'),
                        itemCount: items.length,
                        onPageChanged: (value) {
                          print('value ${value}');
                          setState(() {
                            idx = value;
                          });
                        },
                        itemBuilder: (_, index) {
                          return _buildPageView(items[index]);
                        }),
                  ),
                  _buildNext(idx, items),
                  const Spacer(),
                  _buildIndicator(items.length, idx, items),
                ],
              ),
            )),
          ),
        ),
        onWillPop: () async {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');

          return true;
        });
  }

  ListView _buildPageView(OnBoardingModel item) {

    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          key: const Key('onboardingImage'),
          height: MediaQuery.of(context).size.height * .75,
          decoration: BoxDecoration(
            color: item.primaryColor,
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                  height: item.sizeh.h,
                  width: item.sizew.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.image ?? ''),
                      fit: BoxFit.contain
                    ),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(right: 30, left: 40),
                  child: Text(
                    item.title ?? '',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: item.color,
                        fontSize: item.type == 'rounded' ? 42.sp : 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                  child: Text(
                    item.description ?? '',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: item.color,
                          height: 1.1.h,
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                        ),
                    // textAlign: TextAlign.center,
                    textAlign: item.position,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNext(int idx, List<OnBoardingModel> item) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        InkWell(
            onTap: () {
              idx == item.length - 1
                  ? _navigationService.navigateTo(Routes.loginView)
                  : _nextPage();
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      idx == item.length - 1 ? 'Masuk' : 'Lanjut',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: item[idx].primaryColor,
                          height: 1.4.h,
                          fontSize: 21.sp
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/arrow_forward.svg',
                      color: item[idx].primaryColor,
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                    )
                  ]
              )
            )
        )
      ]
    );

      /*InkWell(
      onTap: () {
        idx == item.length - 1
            ? _navigationService.navigateTo(Routes.loginView)
            : _nextPage();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Text(
                idx == item.length - 1 ? 'Masuk' : 'Lanjut',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: item[idx].primaryColor,
                    height: 1.4.h,
                    fontSize: 21.sp
                ),
              )
          ),
          SvgPicture.asset(
            'assets/svg/arrow_forward.svg',
            color: item[idx].primaryColor,
            width: 30,
            height: 30
          )
        ],
      ),
    );*/
  }

  Widget _buildIndicator(int itemsCount, int idx, List<OnBoardingModel> item) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: itemsCount,
      effect: JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        jumpScale: .8,
        verticalOffset: 15,
        dotColor: Colors.grey,
        activeDotColor: item[idx].primaryColor!,
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.ease);
  }

  SystemUiOverlayStyle _buildHeader(int index, List<OnBoardingModel> item) {
    return SystemUiOverlayStyle(statusBarColor: item[index].secondaryColor);
  }
}
