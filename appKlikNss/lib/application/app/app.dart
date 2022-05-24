import 'package:dio/dio.dart';
import 'package:mobileapps/infrastructure/apis/home_api.dart';
import 'package:mobileapps/ui/component/resulttext_component.dart';
import 'package:mobileapps/ui/shared/bottom_navigation.dart';

import 'package:mobileapps/ui/shared/white.dart';
import 'package:mobileapps/ui/views/home/home_view.dart';
import 'package:mobileapps/ui/views/home/home_viewmodel.dart';
import 'package:mobileapps/ui/views/home/resultSearch_view.dart';
import 'package:mobileapps/ui/views/home/resultSearch_viewmodel.dart';
import 'package:mobileapps/ui/views/home/resultText_view.dart';
import 'package:mobileapps/ui/views/home/search_view.dart';
import 'package:mobileapps/ui/views/login/verifikasi_view.dart';
import 'package:mobileapps/ui/views/sign_in/signin_view.dart';
import 'package:mobileapps/ui/views/sign_up/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/services/dio_service.dart';
import 'package:mobileapps/infrastructure/apis/auth_api.dart';
import 'package:mobileapps/ui/views/login/login_view.dart';
import 'package:mobileapps/ui/views/onboarding/onboarding_view.dart';
import 'package:mobileapps/ui/views/startup/startup_view.dart';

import '../../ui/shared/BottomNavigationBar.dart';

import '../../ui/views/home/search_viewmodel.dart';
import '../../ui/views/home/widget/location_view.dart';


@StackedApp(routes: [
  MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: OnBoardingView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: VerifikasiView),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: SignInView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: bottomNavigationBar),
  MaterialRoute(page: white),
  MaterialRoute(page: resultSearchView),
  MaterialRoute(page: SearchView),
  MaterialRoute(page: resultSearchViewText),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  Singleton(
    classType: DioService,
    resolveUsing: DioService.getInstance,
    asType: Dio,
  ),
  LazySingleton(classType: AuthApi),
  LazySingleton(classType: HomeApi),
  Singleton(classType: HomeViewModel),
  Singleton(classType: SearchViewModel),
  Singleton(classType: resultSearchViewModel),
])
class AppSetup {}
