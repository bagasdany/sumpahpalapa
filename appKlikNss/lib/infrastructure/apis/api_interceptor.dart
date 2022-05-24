import 'package:dio/dio.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/application/app/enums/pop_up_dialog_type.dart';
import 'package:mobileapps/application/helpers/network_helper.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'dart:developer' as developer;

import 'package:stacked_services/stacked_services.dart' as stacked;

class ApiInterceptor extends InterceptorsWrapper {
  // final locator = GetIt.instance;
  final _sharedPrefs = SharedPrefs();

  final Dio api = Dio();
  String? accessToken;
  final _popUpDialogService = locator<stacked.DialogService>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = _sharedPrefs.get(SharedPreferencesKeys.userToken);

    // options.headers['Content-Length'] = token.toString().length;

    options.contentType = "application/json";
    // options.headers['NSST'] = 'KlikNSS-Token';
    options.headers['KlikNSS-Token'] = token ?? '';

    NetworkLogger.logHeaderOptions(token: token, options: options);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(response.toString(), name: response.requestOptions.path);

    NetworkLogger.logResponse(response);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    developer.log(err.toString(), name: err.requestOptions.path);
    if (err.toString().contains('DioErrorType.other')) {
      developer.log(
          //wait bro
          err.toString().contains('DioErrorType.other').toString(),
          name: err.requestOptions.path);
      showNetworkOfflineDialog();
    }

    if (err.response!.statusCode == 401) {
      showSessionExpiredDialog();
    } else if (err.response!.statusCode == 400) {
      showBadRequestDialog(err.response?.data['errors'] ??
          'Server gagal memprosess permintaan anda');
    }
    super.onError(err, handler);
  }

  void showSessionExpiredDialog() async {
    await _popUpDialogService.showCustomDialog(
        variant: PopUpDialogType.base,
        title: 'Sesi telah habis',
        description: 'Tidak ada aktivitas pada aplikasi',
        mainButtonTitle: 'OK');
  }

  void showBadRequestDialog(String description) async {
    await _popUpDialogService.showCustomDialog(
      variant: PopUpDialogType.base,
      title: 'Sorry!',
      description: description,
      mainButtonTitle: 'Oke',
    );
  }

  void showNetworkOfflineDialog() async {
    await _popUpDialogService.showCustomDialog(
        variant: PopUpDialogType.base,
        title: 'Yah, koneksinya terputus',
        description:
            'Cek koneksi wifi atau kouta internet kamu, lalu coba lagi',
        data: {
          'showCornerClearButton': true,
        },
        mainButtonTitle: 'Oke');
  }
}
