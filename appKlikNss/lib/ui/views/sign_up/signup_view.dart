import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/ui/views/sign_up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpView extends ViewModelBuilderWidget<SignUpViewModel> {
  static int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  static final _navigationService = locator<NavigationService>();
  static String? title;
  const SignUpView({Key? key}) : super(key: key);
  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();

  @override
  void onViewModelReady(SignUpViewModel viewModel) => viewModel.initialize();

  @override
  Widget builder(
      BuildContext context, SignUpViewModel viewModel, Widget? child) {
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
                        const EdgeInsets.only(left: 50, right: 50, top: 40),
                    margin: const EdgeInsets.symmetric(vertical: 50),

                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pendaftaran',
                          style: TextStyle(
                              color: CustomColor.primaryBlackColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Masukkan data dibawah ini untuk melanjutkan.....",
                          style: TextStyle(
                            color: CustomColor.primaryBlackColor,
                            fontSize: 16,
                          ),
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
                              Text(
                                'Nama Lengkap',
                                style: TextStyle(
                                  color: CustomColor.primaryBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 60,
                                width: 300,
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          // maxLength: 13,
                                          controller: viewModel.nameController,
                                          onChanged: (value) =>
                                              viewModel.onChangeName(value),
                                          decoration:
                                              const InputDecoration.collapsed(
                                            hintText: 'Masukan Nama Lengkap',
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: CustomColor.primaryBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 60,
                                width: 300,
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          // maxLength: 13,
                                          controller: viewModel.emailController,
                                          onChanged: (value) =>
                                              viewModel.onChangeEmail(value),
                                          decoration:
                                              const InputDecoration.collapsed(
                                            hintText: 'Masukan Email',
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Kode Referral',
                                style: TextStyle(
                                  color: CustomColor.primaryBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 60,
                                width: 300,
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          // maxLength: 13,
                                          controller: viewModel.codeController,
                                          onChanged: (value) =>
                                              viewModel.onChangeCode(value),
                                          decoration:
                                              const InputDecoration.collapsed(
                                            hintText: 'Masukan Kode referal',
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 300,
                                margin: EdgeInsets.only(top: 30),
                                child: TextButton(
                                  onPressed: () {
                                    viewModel.requestUpdateData(
                                        viewModel.nameController.text
                                            .toString(),
                                        viewModel.emailController.text
                                            .toString());
                                    _navigationService
                                        .navigateTo(Routes.signInView);
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
                ],
              )),
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}
