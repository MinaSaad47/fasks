import 'package:flutter/material.dart';

part 'page_title.dart';

class PageAppBar extends AppBar {
  PageAppBar({Key? key, Widget? title})
      : super(
          key: key,
          leadingWidth: 100,
          title: title,
          leading: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    );
                  },
                ),
                const SizedBox(width: 5),
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/',
                        );
                      },
                      icon: const Icon(Icons.arrow_back_sharp),
                    );
                  },
                )
              ],
            ),
          ),
        );
}
