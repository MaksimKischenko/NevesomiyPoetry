
import 'package:shared_preferences/shared_preferences.dart';

mixin PreferencesHelper {

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<T?> read<T>(TypeStoreKey<T> typedStoreKey) async => ((await prefs).get(typedStoreKey.key) as T?)
      ?? typedStoreKey.defaultValue;

  static Future<bool> contains(TypeStoreKey typedStoreKey) async => (await prefs).containsKey(typedStoreKey.key);

  static Future<bool> clear() async => (await prefs).clear();

  static Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value) async {
    if (value == null) {
      await (await prefs).remove(typedStoreKey.key);

      return;
    }
    switch (T) {
      case int:
        await (await prefs).setInt(typedStoreKey.key, value as int);
        break;
      case String:
        await (await prefs).setString(typedStoreKey.key, value as String);
        break;
      case double:
        await (await prefs).setDouble(typedStoreKey.key, value as double);
        break;
      case bool:
        await (await prefs).setBool(typedStoreKey.key, value as bool);
        break;
      case List:
        await (await prefs).setStringList(typedStoreKey.key, value as List<String>);
        break;
    }
  }
}

mixin PrefsKeys {
  static final isDarkTheme = TypeStoreKey<bool>('isDarkTheme', defaultValue: false);
  static final poemsCache = TypeStoreKey<String>('poemsCache', defaultValue: null);
  static final topicName = TypeStoreKey<String>('topicName', defaultValue: null);
  static final sendsMessages = TypeStoreKey<bool>('sendsMessages', defaultValue: false);
}

/// Обьект типизированный ключ используемый в key-value хранилищах для более удобной работы с ними
/// [T] - тип хранимого значения
/// [key] - строковый ключ
/// [defaultValue] - значение по умолчанию
///
/// Хранилище может ограничивать типизацию [T], обычно оно ограничивается стандартными типами: [int], [double], [String], [bool].
class TypeStoreKey<T> {
  final type = T;

  final String key;
  final T? defaultValue;
  TypeStoreKey(
    this.key,{
    this.defaultValue
  });

  @override
  String toString() => 'TypeStoreKey(key: $key, defaultValue: $defaultValue)';
}