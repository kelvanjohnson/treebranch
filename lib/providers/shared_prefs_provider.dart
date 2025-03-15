import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final sharedPreferences = Provider<SharedPreferencesWithCache>((_) => throw UnimplementedError());