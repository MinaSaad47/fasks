import 'package:fasks/fasks/bloc/fasks_bloc.dart';
import 'package:fasks/fasks/fasks_layout.dart';
import 'package:fasks/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FasksView extends StatelessWidget {
  const FasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FasksTheme.lightTheme,
        darkTheme: FasksTheme.darkTheme,
        themeMode: context.select((FasksBloc bloc) => bloc.state.themeMode),
        initialRoute: '/',
        routes: {
          '/': (context) => const FasksLayout(),
        },
      );
    });
  }
}
