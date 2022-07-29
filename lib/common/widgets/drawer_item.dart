import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final MaterialPageRoute route;
  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Scaffold.of(context).closeDrawer();
        Navigator.of(context).popUntil((route) => route.settings.name == '/');
        Navigator.of(context).push(route);
      },
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
