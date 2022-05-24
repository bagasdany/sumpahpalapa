import 'package:flutter/cupertino.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/models/OnBoardingModel.dart';
import 'package:mobileapps/main-dev.dart';

class OnBoardingUtils {
  static List<OnBoardingModel> getItemSplashScreen() {
    final List<OnBoardingModel> onBoardingModels = [];

    return onBoardingModels
      ..add(
        OnBoardingModel(
          title: "Halo",
          sizeh: 200,
          sizew: 200,
          right2: 30,
          left2: 30,
          right3: 20,
          left3: 20,
          right: 30,
          color: CustomColor.primaryWhiteColor,
          left: 30,
          position: TextAlign.center,
          primaryColor: CustomColor.onBoardingRed,
          secondaryColor: CustomColor.secondaryonBoardingRed,
          // imagePath: ,
          type: 'rounded',
          description:
              "Selamat datang di aplikasi mobile KlikNSS, temukan layanan seputar motor Honda disini...",
          image: 'assets/images/onboarding1.jpeg'
        ),
      )
      ..add(
        OnBoardingModel(
          title: "Pengajuan Sepeda Motor Pengajuan Sepeda Motor Pengajuan Sepeda Motor",
          right3: 34,
          left3: 20,
          right2: 120,
          sizeh: 140,
          sizew: 140,
          left2: 0,
          right: 50,
          left: 20,
          color: CustomColor.primaryWhiteColor,
          position: TextAlign.left,
          primaryColor: CustomColor.onBoardingBlue,
          secondaryColor: CustomColor.secondaryonBoardingBlue,
          type: 'not_rounded',
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat sit amet ante sit amet scelerisque. Sed vitae aliquam nunc. Suspendisse quis lobortis lacus.",
          image: 'assets/images/onboarding1.jpeg'
        ),
      )
      ..add(
        OnBoardingModel(
          title: "Pembiayaan Dana",
          right3: 0,
          left3: 20,
          sizeh: 140,
          sizew: 140,
          right2: 120,
          left2: 0,
          right: 50,
          left: 20,
          color: CustomColor.primaryWhiteColor,
          position: TextAlign.left,
          primaryColor: CustomColor.onBoardingGreen,
          secondaryColor: CustomColor.secondaryonBoardingGreen,
          type: 'not_rounded',
          description:
              "Butuh dana untuk mengembangkan usaha, renovasi rumah, biaya kesahatan, biaya pendidikan atau rekreasi bareng keluarga? KlikNSS menawarkan fasilitas.",
        ),
      )
      ..add(
        OnBoardingModel(
          title: "Sparepart",
          right3: 0,
          left3: 135,
          sizeh: 140,
          sizew: 140,
          right2: 120,
          left2: 0,
          right: 50,
          left: 20,
          color: CustomColor.primaryBlackColor,
          position: TextAlign.left,
          primaryColor: CustomColor.onBoardingYellow,
          secondaryColor: CustomColor.secondaryonBoardingYellow,
          type: 'not_rounded',
          description:
              "Kamu dapat melakukan pembelian sepeda motor honda disini."
        ),
      )
      ..add(
        OnBoardingModel(
          title: "Booking Service",
          right3: 0,
          left3: 50,
          sizeh: 140,
          sizew: 140,
          right2: 120,
          left2: 0,
          right: 50,
          left: 20,
          color: CustomColor.primaryWhiteColor,
          position: TextAlign.left,
          primaryColor: CustomColor.onBoardingBlueSea,
          secondaryColor: CustomColor.secondaryonBoardingBlueSea,
          type: 'not_rounded',
          description:
              "Kamu dapat mengambil antrian secara online dengan Booking Service."
        ),
      )
      ..add(
        OnBoardingModel(
          title: "Cek Status & Historis",
          right3: 35,
          left3: 50,
          sizeh: 140,
          sizew: 140,
          right2: 120,
          left2: 0,
          right: 50,
          left: 20,
          color: CustomColor.primaryGrayColor,
          position: TextAlign.left,
          primaryColor: CustomColor.onBoardingGreen2,
          secondaryColor: CustomColor.secondaryonBoardingGreen2,
          type: 'not_rounded',
          description:
              "Kamu dapat cek status pengajuan,pesanan, dan juga history Booking Service."
        ),
      );
  }
}
