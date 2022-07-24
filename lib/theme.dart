import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class FasksTheme {
  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.jungle,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarOpacity: 0.95,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      fabRadius: 40,
      blendOnColors: false,
      bottomNavigationBarElevation: 20,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
  static ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.jungle,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      fabRadius: 40,
      bottomNavigationBarElevation: 20,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
}
