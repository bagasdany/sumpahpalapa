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

class SignUpViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _haseError = ValueNotifier(false);
  final _sharedPrefs = SharedPrefs();
  final _authApi = locator<AuthApi>();
  final _popUpDialogService = locator<DialogService>();

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final res = (SharedPreferencesKeys.userToken);
  final refresh = (SharedPreferencesKeys.refreshToken);
  ValueNotifier<bool> get hasErr => _haseError;

  Future<void> initialize() async {
    final token = await _sharedPrefs.get(SharedPreferencesKeys.userToken);
    // final refreshToken =
    //     await _sharedPrefs.get(SharedPreferencesKeys.refreshToken);
    final res = await runBusyFuture(_authApi.requestToken(token ?? ""));

    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      developer.log('${response.token}', name: 'Tokenn');
      developer.log('${response.refreshToken}', name: 'Refresh');
    });
  }

  void onChangeName(String val) {
    nameController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );
    notifyListeners();
  }

  void onChangeEmail(String val) {
    emailController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );
    notifyListeners();
  }

  void onChangeCode(String val) {
    codeController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );
    notifyListeners();
  }

  Future requestUpdateData(String name, String email) async {
    final res = await runBusyFuture(_authApi.updateData(name, email));

    res.fold((errorResponse) async {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      developer.log('${response.name}', name: 'Nama :');
      developer.log('${response.email}', name: 'Email :');

      //   _navigatorService
      // .navigateTo(Routes.verifikasiView,
      //     arguments: VerifikasiViewArguments(mobileNumber: mobileNumber))
      // ?.whenComplete(() {
      // if (response.isNewCustomer == true) {
      //   _navigatorService.navigateTo(Routes.signUpView);
      // } else {
      //   _navigatorService.navigateTo(Routes.signInView);
      // }
      _navigatorService.navigateTo(Routes.signInView,
          arguments: SignInViewArguments(customerName: name));
    });
  }

  void showBadRequestDialog(String description) async {
    await _popUpDialogService.showCustomDialog(
      variant: PopUpDialogType.base,
      title: 'Sorry!',
      description: description,
      mainButtonTitle: 'Oke',
    );
  }
}
