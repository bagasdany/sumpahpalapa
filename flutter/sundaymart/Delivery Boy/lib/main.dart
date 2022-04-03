import 'dart:io';

import 'package:deliveryboy/routes.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/controllers/chat_controller.dart';
import 'package:deliveryboy/src/controllers/language_controller.dart';
import 'package:deliveryboy/src/controllers/location_controller.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:deliveryboy/translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void initialize() {
  Get.put<AuthController>(AuthController());
  Get.put<SettingsController>(SettingsController());
  Get.put<OrderController>(OrderController());
  Get.put<ChatController>(ChatController());
  Get.put<LocationController>(LocationController());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LanguageController controller =
      Get.put<LanguageController>(LanguageController());
  Map<String, Map<String, String>> translations =
      await controller.getMessages();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await GetStorage.init();
  initialize();

  runApp(MyApp(
    translations: Messages(data: translations),
  ));

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class MyApp extends StatefulWidget {
  final Messages translations;

  const MyApp({Key? key, required this.translations}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(builder: (languageController) {
      return ScreenUtilInit(
        designSize: const Size(414, 902),
        builder: () => GetMaterialApp(
            translations: widget.translations,
            title: 'Githubit Market',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.light,
            initialRoute: "/",
            getPages: AppRoutes.routes),
      );
    });
  }
}
