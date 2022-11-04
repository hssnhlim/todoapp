import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Views/homePageContent.dart';
import 'package:todoapp/Views/profilePage.dart';
import 'package:todoapp/Views/timelinePage.dart';
import 'package:todoapp/Views/widget/dialogbox.dart';
import 'package:todoapp/Views/widget/todotileFolder.dart';
import 'package:todoapp/authentication/login.dart';
import 'package:todoapp/data/localDatabase.dart';

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
  final tabs = [HomePageContent(), TimeLinePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.8),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                  spreadRadius: 5)
            ],
            borderRadius: BorderRadius.only(
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
              padding: EdgeInsets.all(15),
              onTabChange: navigateBtmNavBar,
              curve: Curves.easeInCubic,
              tabs: [
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
    );
  }
}
