enum Flavor {
  DEV,
  PROD,
}

extension FlavorName on Flavor {
  String get name => toString().split('.').last;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Nss';
      case Flavor.PROD:
        return 'Nss';
      default:
        return 'title';
    }
  }

  static final Map<String, dynamic> sharedMap = {};

  static final devMap = {
    'baseURL': 'https://api-dev2.kliknss.co.id',
    ...sharedMap,
  };

  static final prodMap = {
    'baseURL': '',
    ...sharedMap,
  };

  static Map<String, dynamic> get variables {
    switch (appFlavor) {
      case Flavor.DEV:
        return devMap;
      case Flavor.PROD:
        return prodMap;
      default:
        return devMap;
    }
  }
}
