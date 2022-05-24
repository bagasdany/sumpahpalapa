// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../ui/shared/BottomNavigationBar.dart';
import '../../ui/shared/white.dart';
import '../../ui/views/home/home_view.dart';
import '../../ui/views/home/resultSearch_view.dart';
import '../../ui/views/home/resultText_view.dart';
import '../../ui/views/home/search_view.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/login/verifikasi_view.dart';
import '../../ui/views/onboarding/onboarding_view.dart';
import '../../ui/views/sign_in/signin_view.dart';
import '../../ui/views/sign_up/signup_view.dart';
import '../../ui/views/startup/startup_view.dart';
import '../models/home/response_recomendationSearch_model.dart';

class Routes {
  static const String startupView = '/';
  static const String onBoardingView = '/on-boarding-view';
  static const String loginView = '/login-view';
  static const String verifikasiView = '/verifikasi-view';
  static const String signUpView = '/sign-up-view';
  static const String signInView = '/sign-in-view';
  static const String homeView = '/home-view';
  static const String bottomNavigationBar = '/bottom-navigation-bar';
  static const String white = '/white';
  static const String resultSearchView = '/result-search-view';
  static const String searchView = '/search-view';
  static const String resultSearchViewText = '/result-search-view-text';
  static const all = <String>{
    startupView,
    onBoardingView,
    loginView,
    verifikasiView,
    signUpView,
    signInView,
    homeView,
    bottomNavigationBar,
    white,
    resultSearchView,
    searchView,
    resultSearchViewText,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.verifikasiView, page: VerifikasiView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.bottomNavigationBar, page: bottomNavigationBar),
    RouteDef(Routes.white, page: white),
    RouteDef(Routes.resultSearchView, page: resultSearchView),
    RouteDef(Routes.searchView, page: SearchView),
    RouteDef(Routes.resultSearchViewText, page: resultSearchViewText),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    OnBoardingView: (data) {
      var args = data.getArgs<OnBoardingViewArguments>(
        orElse: () => OnBoardingViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingView(key: args.key),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    VerifikasiView: (data) {
      var args = data.getArgs<VerifikasiViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifikasiView(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
    SignInView: (data) {
      var args = data.getArgs<SignInViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInView(
          key: args.key,
          customerName: args.customerName,
        ),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    bottomNavigationBar: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => bottomNavigationBar(),
        settings: data,
      );
    },
    white: (data) {
      var args = data.getArgs<whiteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => white(
          key: args.key,
          customerName: args.customerName,
        ),
        settings: data,
      );
    },
    resultSearchView: (data) {
      var args = data.getArgs<resultSearchViewArguments>(
        orElse: () => resultSearchViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => resultSearchView(
          key: args.key,
          kunci: args.kunci,
        ),
        settings: data,
      );
    },
    SearchView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SearchView(),
        settings: data,
      );
    },
    resultSearchViewText: (data) {
      var args = data.getArgs<resultSearchViewTextArguments>(
        orElse: () => resultSearchViewTextArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => resultSearchViewText(
          key: args.key,
          kunci: args.kunci,
          response: args.response,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// OnBoardingView arguments holder class
class OnBoardingViewArguments {
  final Key? key;
  OnBoardingViewArguments({this.key});
}

/// VerifikasiView arguments holder class
class VerifikasiViewArguments {
  final Key? key;
  final String mobileNumber;
  VerifikasiViewArguments({this.key, required this.mobileNumber});
}

/// SignInView arguments holder class
class SignInViewArguments {
  final Key? key;
  final String customerName;
  SignInViewArguments({this.key, required this.customerName});
}

/// white arguments holder class
class whiteArguments {
  final Key? key;
  final String customerName;
  whiteArguments({this.key, required this.customerName});
}

/// resultSearchView arguments holder class
class resultSearchViewArguments {
  final Key? key;
  final String? kunci;
  resultSearchViewArguments({this.key, this.kunci});
}

/// resultSearchViewText arguments holder class
class resultSearchViewTextArguments {
  final Key? key;
  final String? kunci;
  final ResponseRecomendationModel? response;
  resultSearchViewTextArguments({this.key, this.kunci, this.response});
}
