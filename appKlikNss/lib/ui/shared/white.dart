import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/ui/shared/BottomNavigationBar.dart';
import 'package:mobileapps/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class white extends ViewModelBuilderWidget<LoginViewModel> {
  static int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  static final _navigationService = locator<NavigationService>();
  static String? title;
  final String customerName;
  const white({Key? key, required this.customerName}) : super(key: key);
  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel viewModel) => viewModel.initialize();

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle(statusBarColor: CustomColor.backgroundGrayColor),
      child: Scaffold(
        backgroundColor: CustomColor.backgroundGrayColor,
        body: SafeArea(
          top: false,
          child: GestureDetector(
              onTap: () => _unfocus(context),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 100),
                    margin: const EdgeInsets.symmetric(vertical: 50),

                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lokasi anda berhasil diubah",
                          style: TextStyle(
                            color: CustomColor.primaryBlackColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Lokasi ${customerName}',
                          style: TextStyle(
                              color: CustomColor.primaryBlackColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // color: Colors.red,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      // margin: const EdgeInsets.symmetric(vertical: 50),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              // Text(
                              //   'Nama Lengkap',
                              //   style: TextStyle(
                              //     color: CustomColor.primaryBlackColor,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              Container(
                                height: 50,
                                width: 200,
                                margin: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => HomeView()));
                                    // viewModel.requestOTP(
                                    //   '',
                                    // );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        CustomColor.secondaryRedColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Lanjut',
                                    style: TextStyle(
                                        color: CustomColor.primaryWhiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //     child: Container(
                  //   width: 30,
                  //   height: 30,
                  // ))
                ],
              )),
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}