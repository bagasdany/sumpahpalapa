import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/nss_app.dart';
import 'package:mobileapps/application/helpers/my_http_overrrides.dart';
import 'package:mobileapps/flavors.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';
import 'package:mobileapps/ui/customs/custom_pop_up_dialog/setup_pop_up_dialog_ui.dart';

Future main() async {
  F.appFlavor = Flavor.DEV;

  WidgetsFlutterBinding.ensureInitialized();

  await FlutterLogs.initLogs(
    logLevelsEnabled: [
      LogLevel.INFO,
      LogLevel.WARNING,
      LogLevel.ERROR,
      LogLevel.SEVERE,
    ],
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
    directoryStructure: DirectoryStructure.FOR_DATE,
    logTypesEnabled: ['device', 'network', 'errors', 'notification'],
    logFileExtension: LogFileExtension.TXT,
    logsWriteDirectoryName: 'MyLogs',
    logsExportDirectoryName: 'MyLogs/Exported',
    debugFileOperations: true,
    isDebuggable: true,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Android
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light, // iOS
    ),
  );

  // await initializeDateFormatting('id_ID', "");
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPrefs().init();

  setupLocator();
  setupPopUpDialogUi();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const NssApp());
}
