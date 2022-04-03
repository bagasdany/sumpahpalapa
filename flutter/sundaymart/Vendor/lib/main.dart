import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor/routes.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/controllers/auth_controller.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/controllers/category_controller.dart';
import 'package:vendor/src/controllers/dashboard_controller.dart';
import 'package:vendor/src/controllers/language_controller.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/translations.dart';

void initialize() {
  Get.put<AuthController>(AuthController());
  Get.put<ProductController>(ProductController());
  Get.put<OrderController>(OrderController());
  Get.put<BrandController>(BrandController());
  Get.put<CategoryController>(CategoryController());
  Get.put<DashboardController>(DashboardController());
  Get.put<AdminController>(AdminController());
  Get.put<ShopController>(ShopController());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC-ssyDV5l1y9-vnzJCsaS8FdjhGgmKLF4',
      appId: '1:1084156374123:android:261a61368acca49bb7952e',
      messagingSenderId: '1084156374123',
      projectId: 'vendor-8280d',
    ),
  );
  final LanguageController controller =
      Get.put<LanguageController>(LanguageController());
  Map<String, Map<String, String>> translations =
      await controller.getMessages();

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
