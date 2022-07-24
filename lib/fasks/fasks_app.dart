import 'package:cache/cache.dart';
import 'package:fasks/fasks/fasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FasksApp extends StatelessWidget {
  final Cache _cache;
  final ThemeMode _themeMode;

  const FasksApp({Key? key, required Cache cache, required ThemeMode themeMode})
      : _cache = cache,
        _themeMode = themeMode,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FasksBloc(cache: _cache, themeData: _themeMode),
      child: const FasksView(),
    );
  }
}
