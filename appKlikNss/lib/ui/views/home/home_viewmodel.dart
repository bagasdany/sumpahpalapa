import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/models/home/response_getprov_model.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'dart:developer' as developer;
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';

import '../../../infrastructure/apis/home_api.dart';

class HomeViewModel extends FutureViewModel {
  final _homeApi = HomeApi();
  final searchController = TextEditingController();
  bool loadImage = false;
  final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);

  ResponseHomeModel? homeEntityModel;

  ResponseGetLokasiModel? getlokasiEntityModel;

  @override
  Future futureToRun() async {
    // await Future.delayed(Duration(seconds: 3));
    // setBusy(true);
    // loadImage = true;
    print('call api home');
    apiHome();
    getprov();
    // setBusy(false);

    // LoginViewModel().getprovinsi();
  }

  Future refreshPage() async {
    futureToRun();
  }

  int _selectIndex = 0;
  bool isAppbarCollapsing = false;
  final ScrollController _homeController = new ScrollController();

  Future<void> apiHome() async {
    final res = await runBusyFuture(_homeApi.requestHome());
    print("res : ${res}");
    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      homeEntityModel = response;
      developer.log('${response.banners}', name: 'banners');
      developer.log('${response.categories}', name: 'category');
      developer.log('${response.sections}', name: 'sections');
    });
  }

  Future<void> getprov() async {
    final responnn = await runBusyFuture(_homeApi.requestProvinsii());
    // print("res : ${responnn.data}");
    responnn.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      getlokasiEntityModel = response;
      developer.log('${response.provinces![0].alias}', name: 'alias');
      developer.log('${response.provinces![0].name}', name: 'nama provinsi');
      developer.log('${response.provinces![0].cities![0].name}', name: 'name');
    });
  }
}
