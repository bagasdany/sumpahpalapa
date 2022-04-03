import 'package:deliveryboy/src/pages/chat.dart';
import 'package:deliveryboy/src/pages/language.dart';
import 'package:deliveryboy/src/pages/language_init.dart';
import 'package:deliveryboy/src/pages/loading.dart';
import 'package:deliveryboy/src/pages/lost_connection.dart';
import 'package:deliveryboy/src/pages/main.dart';
import 'package:deliveryboy/src/pages/map.dart';
import 'package:deliveryboy/src/pages/profile.dart';
import 'package:deliveryboy/src/pages/profile_details.dart';
import 'package:deliveryboy/src/pages/settings.dart';
import 'package:deliveryboy/src/pages/sign_in.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => const Loading()),
    GetPage(name: '/home', page: () => const MainPage()),
    GetPage(
        name: '/signin',
        page: () => const SignInPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: '/languageInit', page: () => const LanguageInit()),
    GetPage(name: '/noConnection', page: () => const LostConnection()),
    GetPage(
        name: '/settings',
        page: () => const Settings(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/map',
        page: () => const MapPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/chat',
        page: () => const Chat(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/language',
        page: () => const Languages(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/profile_settings',
        page: () => const ProfileSettings(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}
