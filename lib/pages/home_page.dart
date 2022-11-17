import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'page_1.dart';
import 'page_2.dart';
import 'page_3.dart';
import '../components/draw_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;

  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 41, 46),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/the_witcher.png",
              fit: BoxFit.contain,
              height: 45,
            ),
          ],
        ),
        actions: [
          CupertinoSwitch(
            activeColor: Colors.grey,
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
        ],
      ),
      drawer: DrawHeader(),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        height: 60,
        backgroundColor: Color.fromARGB(255, 32, 41, 46),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            icon: Icon(
              Icons.explore,
              color: Colors.white,
            ),
            label: '',
          ),
          const NavigationDestination(
              icon: Icon(
                Icons.commute,
                color: Colors.white,
              ),
              label: ''),
          const NavigationDestination(
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              label: ''),
        ],
      ),
      body: <Widget>[
        Page1(),
        Page2(),
        Page3(),
      ][currentPageIndex],
    );
  }
}
