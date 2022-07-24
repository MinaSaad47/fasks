import 'package:bloc/bloc.dart';
import 'package:cache/cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'fasks_event.dart';
part 'fasks_state.dart';

class FasksBloc extends Bloc<FasksEvent, FasksState> {
  FasksBloc({required Cache cache, required themeData})
      : _cache = cache,
        super(FasksState(themeMode: themeData)) {
    on<FasksThemeChanged>(_onThemeChanged);
  }
  final Cache _cache;

  Future _onThemeChanged(FasksEvent event, Emitter<FasksState> emit) async {
    await _cache.save(
      key: 'theme_mode',
      value: state.themeMode == ThemeMode.dark ? 'light' : 'dark',
    );
    emit(
      state.copyWith(
        themeMode: state.themeMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark,
      ),
    );
  }
}
