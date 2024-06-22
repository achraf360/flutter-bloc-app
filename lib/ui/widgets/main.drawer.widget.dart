import 'package:enset_app/ui/widgets/drawer.item.widget.dart';
import 'package:flutter/material.dart';

import 'main.drawer.header.widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> menus = [
      {
        "title": "Home",
        "route": "/",
        "leadingIcon": Icons.home,
        "trailingIcon": Icons.arrow_forward_ios
      },
      {
        "title": "Counter Stful",
        "route": "/counter1",
        "leadingIcon": Icons.science_rounded,
        "trailingIcon": Icons.arrow_forward_ios
      },
      {
        "title": "Counter Bloc",
        "route": "/counter2",
        "leadingIcon": Icons.event,
        "trailingIcon": Icons.arrow_forward_ios
      },
      {
        "title": "Git Users",
        "route": "/users",
        "leadingIcon": Icons.people_alt,
        "trailingIcon": Icons.arrow_forward_ios
      },
    ];
    return Drawer(
      child: Column(
        children: [
          const MainDrawerHeader(),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return DrawerItemWidget(
                        title: menus[index]['title'],
                        leadingIcon: menus[index]['leadingIcon'],
                        trailingIcon: menus[index]['trailingIcon'],
                        onAction: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, menus[index]['route']);
                        });
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 6,
                    );
                  },
                  itemCount: menus.length))
        ],
      ),
    );
  }
}
