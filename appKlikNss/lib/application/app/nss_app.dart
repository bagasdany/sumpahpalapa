import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/application/app/enums/connectivity_status.dart';
import 'package:mobileapps/application/services/connectivity_service.dart';

class NssApp extends StatefulWidget {
  const NssApp({Key? key}) : super(key: key);

  @override
  State<NssApp> createState() => _NssAppState();
}

class _NssAppState extends State<NssApp> {
  // final _navigationService = NavigationService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, build) => Listener(
              child: StreamProvider<ConnectivityStatus>(
                initialData: ConnectivityStatus.cellular,
                create: (context) =>
                    ConnectivityService().connectionStatusController.stream,
                child: MaterialApp(
                  title: "Nss",
                  navigatorKey: StackedService.navigatorKey,
                  onGenerateRoute: StackedRouter().onGenerateRoute,
                  debugShowCheckedModeBanner: false,
                ),
              ),
            ));
  }
}
