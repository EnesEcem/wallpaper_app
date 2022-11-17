import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/privacy_polics_page.dart';

import '../model/drawer_header_model.dart';
import '../pages/about_page.dart';
import '../pages/home_page.dart';

class DrawHeader extends StatelessWidget {
  const DrawHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 41, 46),
            ),
            child: Image.asset(
              "assets/the_witcher_2.png",
            ),
          ),
          DrawerPage(
            leading: Icon(Icons.home),
            text: 'HomePage',
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
              );
            },
          ),
          const DrawerPage(
            text: 'Other Apps',
            leading: Icon(Icons.devices_other),
          ),
          DrawerPage(
            text: 'About',
            leading: Icon(Icons.adb_outlined),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => AboutPage(),
                ),
              );
            },
          ),
          DrawerPage(
            text: 'Privacy Policy',
            leading: Icon(Icons.policy_rounded),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => PrivacyPolics(),
                ),
              );
            },
          ),
          DrawerPage(
            text: 'Rate it!',
            leading: Icon(Icons.rate_review),
          ),
          DrawerPage(
            text: 'Recommend to a Friend',
            leading: Icon(Icons.recommend_rounded),
          ),
        ],
      ),
    );
  }
}
