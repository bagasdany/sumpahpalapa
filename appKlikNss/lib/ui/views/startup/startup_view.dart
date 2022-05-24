import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:stacked/stacked.dart';
import 'package:mobileapps/ui/views/startup/startup_viewmodel.dart';

class StartupView extends ViewModelBuilderWidget<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        viewModel.runStartupLogic();
        viewModel.determinePosition();
      });

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: CustomColor.primaryWhiteColor,
      body: Center(
        child: Container(
          height: 200.0,
          width: 300,
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(7.0),
              //     topRight: Radius.circular(7.0),
              //     bottomLeft: Radius.circular(7.0),
              //     bottomRight: Radius.circular(7.0)),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "https://www.kliknss.co.id/images/logo202001.png"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
