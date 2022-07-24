import 'package:fasks/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FasksLayout extends StatelessWidget {
  const FasksLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const NavigationDrawer(),
    );
  }
}
