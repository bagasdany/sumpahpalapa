import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/endpoint.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../application/models/home/response_getprov_model.dart';
import '../../application/models/home/response_home_model.dart';

class HomeApi {
  final Dio _dio = locator<Dio>();
  final _sharedPrefs = SharedPrefs();
  late final ResponseHomeModel? homeModel;
  final _popUpDialogService = locator<DialogService>();

  Future<Either<ResponseHomeModel, ResponseHomeModel>> requestHome() async {
    try {
      const param = "";
      final res2 = await _dio.patch(Endpoint.patchHome, data: param);
      print("respon cek 2 ${res2}");
      return Right(ResponseHomeModel.fromJson(res2.data));
    } on DioError catch (e) {
      return Left(
        ResponseHomeModel.errorJson(
          {
            'error': e.response?.data['error 1'],
            'data': e.response?.data['error data'],
          },
        ),
      );
    }
  }

  Future<Either<ResponseGetLokasiModel, ResponseGetLokasiModel>>
      requestProvinsii() async {
    try {
      const param = {"fields": "id,code,name,alias,cities"};
      final responList =
          await _dio.get(Endpoint.getProvinsi, queryParameters: param);
      // final res2 =    convert.jsonDecode(res.body);
      //

      // CARA 1
      //convert List to Map (LIST MAP)
      // final Map<String, dynamic> responnn = {
      //   for (var items in responList.data) '$items': '$items'
      // };
      //
      // Map<String, dynamic> responnn = responList.data.asMap();

      // var listToPass = jsonDecode(responList.data);
      // List<ResponseGetLokasiModel> bookData = List<ResponseGetLokasiModel>.from(
      //     listToPass.map((i) => ResponseGetLokasiModel.fromJson(i)));
      // print(bookData);
      // responList.data.forEach((responnn) => responnn[responnn.id] =
      //     responnn.code = responnn.name = responnn.alias = responnn.cities);
      // print(responnn);
      // Map.fromIterable(responnn.data, key: (v) => v[0], value: (v) => v[1]);
      // developer.log(res.toString(), name: '[response lokasi] === ');
      // print("responnn ${responnn}");
      // print("response get lokasi ${responnn}");
      return Right(ResponseGetLokasiModel.fromJson(responList.data));
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
