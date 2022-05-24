import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/models/home/response_home_model.dart';
import 'package:mobileapps/application/models/home/response_resultSearch_model.dart';
import 'package:mobileapps/application/models/home/response_search_model.dart';
import 'package:mobileapps/infrastructure/apis/search_api.dart';
import 'dart:developer' as developer;
import 'package:stacked/stacked.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/app/app.router.dart';
import '../../../application/models/home/response_recomendationSearch_model.dart';
import '../../../infrastructure/apis/auth_api.dart';
import '../../../infrastructure/apis/home_api.dart';

class SearchViewModel extends FutureViewModel {
  final _searchApi = SearchApi();
  final searchController = TextEditingController();
  bool loadImage = false;

  final _authApi = locator<AuthApi>();
  final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);
  final _navigatorService = locator<NavigationService>();
  final _haseError = ValueNotifier(false);
  final _sharedPrefs = SharedPrefs();
  final _popUpDialogService = locator<DialogService>();
  ResponseSearchModel? searchEntityModel;
  ResponseSearchResultModel? resultModel;
  ResponseRecomendationModel? resultModeltext;
  void onChangeSearch(String val) {
    searchController.value.copyWith(
      text: val,
      selection:
          TextSelection(baseOffset: val.length, extentOffset: val.length),
    );

    notifyListeners();
  }

  @override
  Future futureToRun() async {
    // await Future.delayed(Duration(seconds: 3));
    // setBusy(true);
    // loadImage = true;
    // print('call api home');
    apiSearch();
    // setBusy(false);
  }

  Future refreshPage() async {
    futureToRun();
  }

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

  Future<void> apiSearch() async {
    final res = await runBusyFuture(_searchApi.postSearch());
    print("res : ${res}");
    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Error get token');
    }, (response) {
      searchEntityModel = response;
      // resultModel;
      developer.log('${response.histories}', name: 'banners');
      developer.log('${response.recommendations}', name: 'category');
      developer.log('${response.recommendations!.sections}', name: 'sections');
    });
  }

  Future resultSearchApi(String key) async {
    final res = await runBusyFuture(_searchApi.postresultSearch(key));

    searchController.clear();
    res.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      resultModel = response;
      developer.log('${response.results}', name: 'Hasil Pencarian');
      _navigatorService
          .navigateTo(Routes.resultSearchView,
              arguments: resultSearchViewArguments(kunci: key))
          ?.whenComplete(() {
        searchController.clear();

        resultModeltext = null;
        notifyListeners();
      });
    });
  }

  Future resultSearchApitext(String key) async {
    final res2 = await runBusyFuture(_searchApi.postresultSearchtext(key));

    res2.fold((errorResponse) {
      developer.log(errorResponse.toString(), name: 'Errorrr get token');
    }, (response) {
      resultModeltext = response;
      developer.log('${response.results}', name: 'Hasil Pencarian2');
      _navigatorService
          .navigateTo(Routes.resultSearchViewText,
              arguments: resultSearchViewTextArguments(kunci: key))
          ?.whenComplete(() {
        // searchController.clear();
        notifyListeners();
      });
    });
  }
}
