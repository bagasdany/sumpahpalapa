import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobileapps/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/application/app/contants/shared_preferences_key.dart';
import 'package:mobileapps/infrastructure/database/shared_prefs.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedPrefs = SharedPrefs();
  Position? currentPosition;
  void _getCurrentLocation() async {
    Position position = await determinePosition();
  }

  final location = SharedPrefs().get(SharedPreferencesKeys.userLocation);

  final username = SharedPrefs().get(SharedPreferencesKeys.customerName);

  void getAddress(latitude, longitude) async {
    try {
      final altitude =
          await _sharedPrefs.set(SharedPreferencesKeys.altitude, latitude);
      final longituds =
          await _sharedPrefs.set(SharedPreferencesKeys.longitude, longitude);
      List<Placemark> placemarks = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];
    } catch (e) {
      print(e);
    }
  }

  Future<Position> getPosition() async {
    LocationPermission permission;
    // final longitude = await _sharedPrefs.set(
    //     SharedPreferencesKeys.altitude, currentPosition!.longitude);
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location not available");
      }
    } else {
      print("Location not available...");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    if (LocationPermission.always == true) {
      print("location permission true ${LocationPermission.always}");
    } else if (LocationPermission.whileInUse == true) {
      print(
          "Location permission while in use ${LocationPermission.whileInUse}");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    } else if (permission == LocationPermission.always) {
      _getCurrentLocation;
      currentPosition = await getPosition();

      getAddress(currentPosition!.latitude, currentPosition!.longitude);
      print("lokasion ${currentPosition!.altitude}");
      print("lokasion ${currentPosition!.latitude}");
      // final altitude = await _sharedPrefs.set(
      //     SharedPreferencesKeys.altitude, currentPosition!.altitude);
      // final longitude = await _sharedPrefs.set(
      //     SharedPreferencesKeys.altitude, currentPosition!.longitude);

      LoginViewModel().lokasi();
      print("lokasi ${LoginViewModel().lokasi()}");
      // final token2 =
      //     await _sharedPrefs.set(SharedPreferencesKeys.userLocation, res);

    } else if (permission == LocationPermission.whileInUse) {
      _getCurrentLocation;
      currentPosition = await getPosition();

      getAddress(currentPosition!.latitude, currentPosition!.longitude);
      print("lokasion ${currentPosition!.altitude}");
      print("lokasion ${currentPosition!.latitude}");
      getAddress(currentPosition!.latitude, currentPosition!.longitude);
      // final altitude = await _sharedPrefs.set(
      //     SharedPreferencesKeys.altitude, currentPosition!.altitude);
      // final longitude = await _sharedPrefs.set(
      //     SharedPreferencesKeys.altitude, currentPosition!.longitude);
      getAddress(currentPosition!.latitude, currentPosition!.longitude);
      LoginViewModel().lokasi();
      print("lokasi ${LoginViewModel().lokasi()}");
      // final token2 =
      //     await _sharedPrefs.set(SharedPreferencesKeys.userLocation, res);

    }
    _getCurrentLocation;
    currentPosition = await getPosition();

    getAddress(currentPosition!.latitude, currentPosition!.longitude);

    return await Geolocator.getCurrentPosition();
  }

  Future runStartupLogic() async {
    LoginViewModel().initialize();
    final newInstall =
        await _sharedPrefs.get(SharedPreferencesKeys.isNewInstall);

    final token = await _sharedPrefs.get(SharedPreferencesKeys.userToken);

    if (token != null || token == "") {
      _navigationService.navigateTo(Routes.bottomNavigationBar);
    } else {
      _navigationService.navigateTo(Routes.onBoardingView);
    }
  }
}
