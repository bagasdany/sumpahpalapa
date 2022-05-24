import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> set(String key, dynamic value) {
    assert(
      value is bool || value is double || value is int || value is String,
      'Unsupported type',
    );

    final Map<Type, Function> typeResolvers = {
      bool: _sharedPrefs!.setBool,
      double: _sharedPrefs!.setDouble,
      int: _sharedPrefs!.setInt,
      String: _sharedPrefs!.setString,
    };

    return typeResolvers[value.runtimeType]!(key, value);
  }

  dynamic get(String key) => _sharedPrefs?.get(key);

  Future<bool> remove(String key) => _sharedPrefs!.remove(key);
}
