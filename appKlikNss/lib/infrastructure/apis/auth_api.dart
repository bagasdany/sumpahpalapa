import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/endpoint.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/application/app/enums/pop_up_dialog_type.dart';
import 'package:mobileapps/application/models/auth/response_otp_model.dart';
import 'package:mobileapps/application/models/auth/response_token_model.dart';
import 'package:mobileapps/application/models/auth/response_update_model.dart';
import 'package:mobileapps/application/models/auth/response_verification_model.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'package:stacked/stacked_annotations.dart';
import 'dart:developer' as developer;
import 'package:stacked_services/stacked_services.dart';

import '../../application/models/auth/response_lokasi_model.dart';

class AuthApi {
  final Dio _dio = locator<Dio>();
  Map data = {};
  final _sharedPrefs = SharedPrefs();
  ResponseOtpModel? otpModel;
  final _popUpDialogService = locator<DialogService>();

  Future<Either<ResponseTokenModel, ResponseTokenModel>> requestToken(
      String token) async {
    try {
      final param = token == "" ? "" : {'token': token};

      final res = await _dio.post(Endpoint.requestToken, data: param);
      _sharedPrefs.set(
        SharedPreferencesKeys.userToken,
        res.data['refreshToken'],
      );
      return Right(ResponseTokenModel.fromJson(res.data));
    } on DioError catch (e) {
      return Left(ResponseTokenModel.errorJson({
        'error': e.response?.data['error']?['msg'],
        'data': e.response?.data['error']?['data'],
      }));
    }
  }

  Future<Either<ResponseOtpModel, ResponseOtpModel>> requestOtp(
      String mobileNumber) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      final param = mobileNumber == "" ? "" : {'mobileNumber': mobileNumber};
      final res = await _dio.post(Endpoint.requestOtp, data: param);
      _sharedPrefs.set(
        SharedPreferencesKeys.customerId,
        res.data['customerId'],
      );
      _sharedPrefs.set(
        SharedPreferencesKeys.id,
        res.data['customerId'],
      );

      return Right(ResponseOtpModel.fromJson(res.data));
    } on DioError catch (e) {
      return Left(ResponseOtpModel.errorJson({
        'error': e.response?.data['error 1'],
        'data': e.response?.data['error data'],
      }));
    }
  }

  Future<Either<ResponseVerificationModel, ResponseVerificationModel>>
      requestVerification(String verificationCode) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      final customerId =
          await _sharedPrefs.get(SharedPreferencesKeys.customerId);

      final param = {
        "customerId": customerId,
        "verificationCode": int.parse(verificationCode)
      };
      // var errorMessage = "Kode Verifikasi salah";
      final res = await _dio.post(Endpoint.verificationOtp, data: param);

      developer.log(res.toString(), name: '[response api] === ');
      // _sharedPrefs.set(
      //   SharedPreferencesKeys.customerName,
      //   res.data['customerName'],
      // );
      return Right(ResponseVerificationModel.fromJson(res.data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        //Alert(context: context, title: "RFLUTTER", desc: "Kode Verifikasisalah").show()
        // return Left(ResponseVerificationModel.errorJson({
        //   'error': e.response?.data['error'],
        //   'data': e.response?.data['error'],
        // }));
        showBadRequestDialog(e.response!.data["errors"]);
      }
      return Left(ResponseVerificationModel.errorJson({
        'error': e.response?.data['errors'],
        'data': e.response?.data['errors'],
      }));
    }
  }

  void showBadRequestDialog(String description) async {
    await _popUpDialogService.showCustomDialog(
      variant: PopUpDialogType.base,
      title: 'Sorry!',
      description: description,
      mainButtonTitle: 'Oke',
    );
  }

  void cek(BuildContext context) {
    final alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("There was an error during login."),
      actions: [FlatButton(child: const Text("OK"), onPressed: () {})],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Either<ResponseUpdateModel, ResponseUpdateModel>> updateData(
      String name, String email) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      // final customerId =
      //     await _sharedPrefs.get(SharedPreferencesKeys.customerId);

      final id = await _sharedPrefs.get(SharedPreferencesKeys.customerId);

      final param = {"id": id, "name": name, "email": email};

      final res = await _dio.post(Endpoint.updateUser, data: param);
      developer.log(res.toString(), name: '[response api] === ');
      return Right(ResponseUpdateModel.fromJson(res.data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        showAlertDialog;
        // WidgetsBinding.instance?.addPostFrameCallback((_) => showAlertDialog());
        // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
        // cek(content);
        return Left(ResponseUpdateModel.errorJson({
          'error': e.response?.data['error'],
          'data': e.response?.data['error'],
        }));
      }
      return Left(ResponseUpdateModel.errorJson({
        'error': e.response?.data['error'],
        'data': e.response?.data['error'],
      }));
    }
  }

  Future<Either<ResponseLokasiModel, ResponseLokasiModel>> requestLokasi(
      String alias, String name) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      // final customerId =
      //     await _sharedPrefs.get(SharedPreferencesKeys.customerId);

      final longitude = await _sharedPrefs.get(SharedPreferencesKeys.longitude);
      final altitude = await _sharedPrefs.get(SharedPreferencesKeys.altitude);

//   Map data = {'cn': 'iPhone_11', 'qt': '20', 'ct': 'Delhi'};
// dynamic getData(dynamic token) {
// dio.options.headers['Authorization'] = '$token';
// return await dio.get<dynamic>('https://address',
//     data: jsonEncode(data);
// }
      Map data = {'lat': altitude, 'lng': longitude};
      final param = {"lat": altitude, "lng": longitude};
      // var queryParameters = {
      //   'lat': '${altitude}',
      //   'lng': '${longitude}',
      // };
      final res = await _dio.get(Endpoint.requestKota, queryParameters: param);
      //  final res = await _dio.post(Endpoint.requestToken, data: param);
      _sharedPrefs.set(
        SharedPreferencesKeys.userLocation,
        res.data['name'],
      );
      print("res kota ${res}");
      developer.log(res.toString(), name: '[response lokasi] === ');
      return Right(ResponseLokasiModel.fromJson(res.data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        showAlertDialog;
        // WidgetsBinding.instance?.addPostFrameCallback((_) => showAlertDialog());
        // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
        // cek(content);
        return Left(ResponseLokasiModel.errorJson({
          'error': e.response?.data['error'],
          'data': e.response?.data['error'],
        }));
      }
      return Left(ResponseLokasiModel.errorJson({
        'error': e.response?.data['error'],
        'data': e.response?.data['error'],
      }));
    }
  }

  Future<Either<ResponseGetLokasiModel, ResponseGetLokasiModel>>
      requestProvinsi() async {
    try {
      final param = {"fields": "id,code,name,alias,cities"};

      final res = await _dio.get(Endpoint.getProvinsi, queryParameters: param);
      developer.log(res.toString(), name: '[response lokasi] === ');
      return Right(ResponseGetLokasiModel.fromJson(res.data));
    } on DioError catch (e) {
      // if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
      //   showAlertDialog;
      //   // WidgetsBinding.instance?.addPostFrameCallback((_) => showAlertDialog());
      //   // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
      //   // cek(content);
      //   return Left(ResponseGetLokasiModel.errorJson({
      //     'error': e.response?.data['error'],
      //     'data': e.response?.data['error'],
      //   }));
      // }
      return Left(ResponseGetLokasiModel.errorJson({
        'error': e.response?.data['error'],
        'data': e.response?.data['error'],
      }));
    }
  }
}
