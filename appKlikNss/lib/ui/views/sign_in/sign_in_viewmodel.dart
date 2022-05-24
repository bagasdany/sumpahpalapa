import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/application/app/enums/pop_up_dialog_type.dart';
import 'package:mobileapps/infrastructure/apis/home_api.dart';
import 'dart:developer' as developer;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';

class SignInModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _haseError = ValueNotifier(false);
  final _sharedPrefs = SharedPrefs();
  final _authApi = locator<AuthApi>();
  final _popUpDialogService = locator<DialogService>();

  // String _errorMesage = 'Terjadi kesalahan';
  // final TextEditingController otpController = TextEditingController();
  final res = (SharedPreferencesKeys.userToken);
  final refresh = (SharedPreferencesKeys.refreshToken);
  ValueNotifier<bool> get hasErr => _haseError;
  final String tempNumber = '';
}
