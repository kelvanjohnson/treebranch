// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared_prefs_provider.dart';

part 'token_provider.g.dart';

/* @riverpod
String tokenNotifier(Ref ref, String token) {
  final SharedPreferencesWithCache pref = ref.watch(sharedPreferences);
  return pref.getString(token) ?? "";
} */

@riverpod
class TokenNotifier extends _$TokenNotifier {
  @override
  String build(String token) {
    SharedPreferencesWithCache pref = ref.watch(sharedPreferences);
    return pref.getString(token) ?? "";
  }

  void update([String? newToken]) {
    SharedPreferencesWithCache pref = ref.read(sharedPreferences);
    if (newToken != null) {
      state = newToken;
    }
    else {
      state = pref.getString(token) ?? "";
    }
  }
}