import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/ui/shared/DialogLoading.dart';
import 'package:mobileapps/ui/views/login/verifikasi_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifikasiView extends ViewModelBuilderWidget<VerifikasiViewModel> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  int endTime2 = DateTime.now().millisecondsSinceEpoch + 1000 * 90;
  // final _navigationService = locator<NavigationService>();
  String? title;
  final String mobileNumber;
  bool isLoading = false;

  String display = '';

  VerifikasiView({Key? key, required this.mobileNumber}) : super(key: key);
  @override
  VerifikasiViewModel viewModelBuilder(BuildContext context) =>
      VerifikasiViewModel();

  void nextField({String? value, FocusNode? focus}) {
    if (value!.length == 1) {
      focus!.requestFocus();
    }
  }

  //

  Widget field({FocusNode? focus, FocusNode? next, bool autofocus = false}) {
    return Container(
      width: 64,
      child: TextFormField(
          autofocus: autofocus,
          focusNode: focus,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onChanged: (e) {
            next != null ? nextField(value: e, focus: next) : null;
          },
          decoration: const InputDecoration(
              fillColor: Colors.green,
              border: OutlineInputBorder(borderSide: BorderSide.none))),
    );
  }

  @override
  void onViewModelReady(VerifikasiViewModel viewModel) =>
      viewModel.initialize();

  @override
  Widget builder(
      BuildContext context, VerifikasiViewModel viewModel, Widget? child) {
    // var newString = mobileNumber.substring(mobileNumber.length - 3);
    var newString = mobileNumber.substring(0, mobileNumber.length - 5);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle(statusBarColor: CustomColor.backgroundGrayColor),
      child: Scaffold(
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
        // Navigator.pop(context, const HomeView());
        body: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verifikasi',
                style: TextStyle(
                    color: CustomColor.primaryBlackColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(),
              Text(
                'Kode verifikasi telah dikirimkan ke nomor +${newString}xxxxxx',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    color: CustomColor.primaryBlackColor, fontSize: 14),
                textAlign: TextAlign.left,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Kode Verifikasi',
                    style: TextStyle(
                        color: CustomColor.primaryGrayColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        pastedTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 235, 4, 4),
                          fontWeight: FontWeight.bold,
                        ),
                        // obscureText: true,
                        // obscuringCharacter: '*',
                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        controller: viewModel.valueOtpController,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            inactiveColor: CustomColor.primaryWhiteColor,
                            inactiveFillColor: CustomColor.primaryWhiteColor,
                            selectedColor: CustomColor.primaryRedColor,
                            selectedFillColor: CustomColor.primaryRedColor),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        onChanged: (value) {
                          viewModel.onChangeValueOtp(value);
                        },
                      )),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    child: TextButton(
                      onPressed: () {
                        // viewModel.requestVerificationCode(
                        //   viewModel.otpController.text.toString(),
                        // );
                        //_navigationService.navigateTo(Routes.updateView);
                        viewModel.requestVerificationCode(
                            viewModel.valueOtpController.text);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: CustomColor.secondaryRedColor,
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
              SizedBox(
                height: marginlvl5,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (_, time) {
                      if (time == null) {
                        return Center(
                          child: Container(
                            height: 40,
                            width: 200,
                            margin: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () {
                                // var nomor = viewModel.OTPresend(mobileNumber);
                                // var kodenegara = "+62";
                                var nomorhp = "${mobileNumber}";

                                // viewModel.OTPresend(nomorhp);
                                // var nomorhp = "${mobileNumber}";
                                isLoading = true;
                                timer();
                                VerifikasiViewModel().OTPresend(nomorhp);
                                timer();
                                CountdownTimer(
                                  endTime: endTime2,
                                  widgetBuilder: (_, time) {
                                    if (time == null) {
                                      return Center(
                                        child: Container(
                                          height: 40,
                                          width: 200,
                                          margin: EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              // var nomor = viewModel.OTPresend(mobileNumber);
                                              // var kodenegara = "+62";
                                              var nomorhp = "${mobileNumber}";

                                              VerifikasiViewModel()
                                                  .OTPresend(nomorhp);
                                              // Timer();
                                            },
                                            child: Text(
                                              'Kirim Ulang ',
                                              style: TextStyle(
                                                  color: CustomColor
                                                      .primaryRedColor,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'kirim ulang',
                                          style: TextStyle(
                                            color: CustomColor.primaryGrayColor,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          time.sec! < 10
                                              ? '(00:0${time.sec}) '
                                              : '(00:${time.sec}) ',
                                          style: TextStyle(
                                            color: CustomColor.primaryRedColor,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    );
                                    // Text('kirim ulang (00:${time.sec}) ')
                                  },
                                );
                                isLoading = false;

                                // Timer();
                              },
                              child: Text(
                                isLoading == false
                                    ? 'Kirim Ulang'
                                    : 'Sedang mengirim',
                                style: TextStyle(
                                    color: CustomColor.primaryRedColor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'kirim ulang',
                            style: TextStyle(
                              color: CustomColor.primaryGrayColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '(00:${time.sec! < 10 ? "0${time.sec}" : time.sec}) ',
                            style: TextStyle(
                              color: CustomColor.primaryRedColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      );
                      // Text('kirim ulang (00:${time.sec}) ')
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Center(
        child: CountdownTimer(
          endTime: endTime2,
          widgetBuilder: (_, time) {
            if (time == null) {
              return Center(
                child: Container(
                  height: 40,
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      // var nomor = viewModel.OTPresend(mobileNumber);
                      // var kodenegara = "+62";
                      var nomorhp = "${mobileNumber}";

                      VerifikasiViewModel().OTPresend(nomorhp);
                      // Timer();
                    },
                    child: Text(
                      'Kirim Ulang ',
                      style: TextStyle(
                          color: CustomColor.primaryRedColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'kirim ulang',
                  style: TextStyle(
                    color: CustomColor.primaryGrayColor,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  time.sec! < 10 ? '(00:${time.sec}) ' : '(00:${time.sec}) ',
                  style: TextStyle(
                    color: CustomColor.primaryRedColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            );
            // Text('kirim ulang (00:${time.sec}) ')
          },
        ),
      ),
    );
  }

  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();
}
