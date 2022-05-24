import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'dart:developer' as developer;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';

class VerifikasiViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _haseError = ValueNotifier(false);
  final _sharedPrefs = SharedPrefs();
  final _authApi = locator<AuthApi>();

  // final _popUpDialogService = locator<DialogService>();

  // String _errorMesage = 'Terjadi kesalahan';
  final res = (SharedPreferencesKeys.userToken);
  final refresh = (SharedPreferencesKeys.refreshToken);
  ValueNotifier<bool> get hasErr => _haseError;
  final valueOtpController = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  @override
  initState() {
    // super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        // setState(() {
        secondsRemaining--;
        // });
      } else {
        // setState(() {
        enableResend = true;
        // });
      }
    });
  }

  Future<void> initialize() async {
    final token = await _sharedPrefs.get(SharedPreferencesKeys.userToken);
    final refreshToken =
        await _sharedPrefs.get(SharedPreferencesKeys.refreshToken);
    final res = await runBusyFuture(_authApi.requestToken(token ?? ""));

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      developer.log('${response.token}', name: 'Tokenn');
      developer.log('${response.refreshToken}', name: 'Refresh');
    });
  }

  void onChangeValueOtp(String val) {
    valueOtpController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );
    notifyListeners();
  }

  Future requestOTP(String mobileNumber) async {
    final res = await runBusyFuture(_authApi.requestOtp(mobileNumber));

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      developer.log('${response.verificationCode}', name: 'Kode Verifikasi');
      _navigatorService
          .navigateTo(Routes.verifikasiView,
              arguments: VerifikasiViewArguments(mobileNumber: mobileNumber))
          ?.whenComplete(() {
        notifyListeners();
      });
    });
  }

  Future OTPresend(String mobileNumber) async {
    final res = await runBusyFuture(_authApi.requestOtp(mobileNumber));

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      developer.log('${response.verificationCode}', name: 'Kode Verifikasi');
      // _navigatorService
      //     .navigateTo(Routes.verifikasiView,
      //         arguments: VerifikasiViewArguments(mobileNumber: mobileNumber))
      //     ?.whenComplete(() {
      //   notifyListeners();
      // });
    });
  }

  Future requestVerificationCode(String verificationCode) async {
    final res =
        await runBusyFuture(_authApi.requestVerification(verificationCode));

    res.fold((errorResponse) async {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
      valueOtpController.clear();
    }, (response) {
      valueOtpController.clear();
      developer.log('${response.isNewCustomer}', name: 'isNewCustomer');
      developer.log('${response.customerId}', name: 'Customer Id');
      developer.log('${response.customerName}', name: 'Customer Name');
      if (response.isNewCustomer == true) {
        _navigatorService.navigateTo(Routes.signUpView)?.whenComplete(() {
          notifyListeners();
        });
      } else if (response.isNewCustomer == false) {
        // final customerName =
        //     _sharedPrefs.get(SharedPreferencesKeys.customerName);
        _navigatorService
            .navigateTo(Routes.signInView,
                arguments: SignInViewArguments(
                    customerName: response.customerName.toString()))
            ?.whenComplete(() {
          notifyListeners();
        });
      }
    });
  }
}
// _navigatorService
//           .navigateTo(Routes.verifikasiView,
//               arguments: VerifikasiViewArguments(mobileNumber: mobileNumber))
//           ?.whenComplete(() {
//         notifyListeners();
//       });