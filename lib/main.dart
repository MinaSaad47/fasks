import 'package:bloc/bloc.dart';
import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:fasks/FasksBlocObserver.dart';
import 'package:fasks/fasks/fasks.dart';
import 'package:flutter/material.dart';

Future main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      var cache = CacheSharedPref();
      final String? themeMode = await cache.load('theme_mode');
      runApp(FasksApp(
        cache: cache,
        themeMode: themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light,
      ));
    },
    blocObserver: FasksBlocObserver(),
  );
}
