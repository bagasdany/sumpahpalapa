import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/contants/endpoint.dart';
import 'package:mobileapps/application/models/home/response_recomendationSearch_model.dart';
import 'package:mobileapps/application/models/home/response_resultSearch_model.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../application/app/app.router.dart';
import '../../application/models/home/response_search_model.dart';

class SearchApi {
  final Dio _dio = locator<Dio>();
  final _sharedPrefs = SharedPrefs();
  late final ResponseSearchModel? homeModel;

  final _navigatorService = locator<NavigationService>();
  final _popUpDialogService = locator<DialogService>();

  Future<Either<ResponseSearchModel, ResponseSearchModel>> postSearch() async {
    try {
      const param = "";
      final res2 = await _dio.post(Endpoint.initialSearch, data: param);
      print("respon post ${res2}");
      return Right(ResponseSearchModel.fromJson(res2.data));
    } on DioError catch (e) {
      return Left(
        ResponseSearchModel.errorJson(
          {
            'error': e.response?.data['error 1'],
            'data': e.response?.data['error data'],
          },
        ),
      );
    }
  }

  Future<Either<ResponseSearchResultModel, ResponseSearchResultModel>>
      postresultSearch(String key) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      final param = key == "" ? "" : {'key': key};
      final res = await _dio.post(Endpoint.initialSearch, data: param);

      return Right(ResponseSearchResultModel.fromJson(res.data));
    } on DioError catch (e) {
      return Left(ResponseSearchResultModel.errorJson({
        'error': e.response?.data['error 1'],
        'data': e.response?.data['error data'],
      }));
    }
  }

  Future<Either<ResponseRecomendationModel, ResponseRecomendationModel>>
      postresultSearchtext(String key) async {
    try {
      // final param =
      //     token == "" ? "" : {'token': token, 'mobileNumber': mobileNumber};
      final paramtext = key == "" ? "" : {'key': key};
      final res = await _dio.post(Endpoint.Searchresult, data: paramtext);
      // _navigatorService.navigateTo(Routes.resultSearchView,
      //     arguments: resultSearchViewTextArguments(kunci: res));
      return Right(ResponseRecomendationModel.fromJson(res.data));
    } on DioError catch (e) {
      return Left(ResponseRecomendationModel.errorJson({
        'error': e.response?.data['error 1'],
        'data': e.response?.data['error data'],
      }));
    }
  }
}
