import 'package:fasks/common/common.dart';
import 'package:fasks/fasks/bloc/fasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: const PageTitle(
          title: 'Settings',
          icon: Icons.settings_outlined,
          subtitle: 'where you can change your preferences',
        ),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Theme Mode',
                  style: Theme.of(context).textTheme.headline4,
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
