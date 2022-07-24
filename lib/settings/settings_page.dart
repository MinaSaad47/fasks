import 'package:fasks/settings/settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}
