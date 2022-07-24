part of 'fasks_bloc.dart';

@immutable
class FasksState extends Equatable {
  ThemeMode themeMode;
  FasksState({
    required this.themeMode,
  });

  FasksState copyWith({
    ThemeMode? themeMode,
  }) =>
      FasksState(
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object?> get props => [themeMode];
}
