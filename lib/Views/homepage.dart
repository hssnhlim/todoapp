import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todoapp/Views/homePageContent.dart';
import 'package:todoapp/Views/profilePage.dart';
import 'package:todoapp/Views/timelinePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void navigateBtmNavBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

// List of pages for nav bar
  final tabs = [
    const HomePageContent(),
    const TimeLinePage(),
    const ProfilePage()
  ];

  Future<bool?> _onBackPressed() async {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            actionsPadding:
                const EdgeInsets.only(right: 20, left: 20, top: 0, bottom: 20),
            title: const Text(
              'Do you really want to exit the app?',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  SystemNavigator.pop();
                  // exit(0);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final warning = await _onBackPressed();
        return warning ?? false;
      },
      child: Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.8),
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                    spreadRadius: 5)
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
                color: Colors.grey,
                activeColor: Colors.black,
                backgroundColor: Colors.white,
                tabBackgroundColor: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]
                    .shade100,
                gap: 10,
                padding: const EdgeInsets.all(15),
                onTabChange: navigateBtmNavBar,
                curve: Curves.easeInCubic,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.calendar_month,
                    text: 'Timeline',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
