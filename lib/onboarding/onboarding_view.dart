import 'package:fasks/fasks/bloc/fasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboadingView extends StatelessWidget {
  const OnboadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Hello World'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FasksBloc>().add(FasksThemeChanged());
            },
            icon: Icon(
              context.select((FasksBloc bloc) => bloc.state.themeMode) ==
                      ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          )
        ],
      ),
    );
  }
}
