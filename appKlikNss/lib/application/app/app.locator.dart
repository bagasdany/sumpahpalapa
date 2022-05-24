// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../infrastructure/apis/auth_api.dart';
import '../../infrastructure/apis/home_api.dart';
import '../../ui/views/home/home_viewmodel.dart';
import '../../ui/views/home/resultSearch_viewmodel.dart';
import '../../ui/views/home/search_viewmodel.dart';
import '../services/dio_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerSingleton<Dio>(DioService.getInstance());
  locator.registerLazySingleton(() => AuthApi());
  locator.registerLazySingleton(() => HomeApi());
  locator.registerSingleton(HomeViewModel());
  locator.registerSingleton(SearchViewModel());
  locator.registerSingleton(resultSearchViewModel());
}
