import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/ui/shared/DialogLoading.dart';
import 'package:mobileapps/ui/views/login/widget/verifikasi_arguments.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends ViewModelBuilderWidget<LoginViewModel> {
  static int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  static final _navigationService = locator<NavigationService>();
  static String? title;

  const LoginView({Key? key}) : super(key: key);

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
      child: DialogLoading(
        isLoading: viewModel.isBusy,
        child: Scaffold(
          backgroundColor: CustomColor.backgroundGrayColor,
          appBar: AppBar(
            backgroundColor: CustomColor.backgroundGrayColor,
            shadowColor: CustomColor.transparentColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(""),
            centerTitle: true,
          ),
          body: SafeArea(
            top: false,
            child: GestureDetector(
                onTap: () => _unfocus(context),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 50.w, right: 50.w, top: 70.h),
                      margin: EdgeInsets.symmetric(vertical: 50.h),

                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Masuk',
                            style: TextStyle(
                                color: CustomColor.primaryBlackColor,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Masukkan nomor hp anda dibawah untuk melanjutkan.....",
                            style: TextStyle(
                              color: CustomColor.primaryBlackColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      // color: Colors.red,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50.w, right: 50.w),
                      // margin: const EdgeInsets.symmetric(vertical: 50),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nomor Hp',
                                style: TextStyle(
                                  color: CustomColor.primaryBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 60.h,
                                width: 300.w,
                                // ignore: prefer_const_constructors
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryWhiteColor,
                                  // borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text('+62'),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: viewModel.otpController,
                                          onChanged: (value) =>
                                              viewModel.onChangeOtp(value),
                                          decoration:
                                              const InputDecoration.collapsed(
                                            hintText: 'Masukan Nomor HP',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            //To remove first '0'
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'^0+')),
                                            //To remove first '94' or your country code
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'^62+')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.h,
                                width: 300.w,
                                margin: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  onPressed: () {
                                    var mobileNumber =
                                        viewModel.otpController.text.toString();
                                    viewModel.requestOTP(
                                      '+62${mobileNumber}',
                                    );
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
                    // Expanded(
                    //     child: Container(
                    //   width: 30,
                    //   height: 30,
                    // ))
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}
