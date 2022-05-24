import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/application/app/enums/pop_up_dialog_type.dart';
import 'dart:developer' as developer;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _navigatorService = locator<NavigationService>();
  final _haseError = ValueNotifier(false);
  final _sharedPrefs = SharedPrefs();
  final _authApi = locator<AuthApi>();
  final _popUpDialogService = locator<DialogService>();

  // String _errorMesage = 'Terjadi kesalahan';
  final TextEditingController otpController = TextEditingController();
  final res = (SharedPreferencesKeys.userToken);
  final refresh = (SharedPreferencesKeys.refreshToken);
  ValueNotifier<bool> get hasErr => _haseError;
  final String tempNumber = '';

  Future<void> initialize() async {
    final token = await _sharedPrefs.get(SharedPreferencesKeys.userToken);
    // final refreshToken =
    //     await _sharedPrefs.get(SharedPreferencesKeys.refreshToken);
    final res = await runBusyFuture(_authApi.requestToken(token ?? ""));
    // final token2 =
    //     await _sharedPrefs.set(SharedPreferencesKeys.userLocation, res);

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      developer.log('${response.token}', name: 'Tokenn');
      developer.log('${response.refreshToken}', name: 'Refresh');
    });
  }

  Future<void> lokasi() async {
    final altitude = await _sharedPrefs.get(SharedPreferencesKeys.altitude);
    final longitude = await _sharedPrefs.get(SharedPreferencesKeys.longitude);
    //lat dan long disini sudah dapat 22nya
    // final refreshToken =
    final res = await runBusyFuture(
        _authApi.requestLokasi(altitude.toString(), longitude.toString()));
    // final token2 =
    //     await _sharedPrefs.set(SharedPreferencesKeys.userLocation, res);

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      developer.log('${response.alias}', name: 'alias');
      developer.log('${response.name}', name: 'name');
    });
  }

  void onChangeOtp(String val) {
    otpController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );

    notifyListeners();
  }

  Future requestOTP(String mobileNumber) async {
    final res = await runBusyFuture(_authApi.requestOtp(mobileNumber));

    otpController.clear();
    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      developer.log('${response.verificationCode}', name: 'Kode Verifikasi');
      _navigatorService
          .navigateTo(Routes.verifikasiView,
              arguments: VerifikasiViewArguments(mobileNumber: mobileNumber))
          ?.whenComplete(() {
        otpController.clear();
        notifyListeners();
      });
    });
  }

  void showBadRequestDialog(String description) async {
    await _popUpDialogService.showCustomDialog(
      variant: PopUpDialogType.base,
      title: 'Mohon Maaf!',
      description: description,
      mainButtonTitle: 'Oke',
    );
  }
}
