import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todoapp/Views/about_us_page.dart';
import 'package:todoapp/Views/detail_user_profile.dart';
import 'package:todoapp/Views/edit_profile.dart';

import '../authentication/auth.provider.dart';
import '../authentication/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final page = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: const DetailUserProfile(),
                      type: PageTransitionType.rightToLeft,
                      childCurrent: const ProfilePage(),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInCubic));
                },
                child: Container(
                  width: double.maxFinite,
                  height: 55,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'User profile',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black.withOpacity(.6),
                          )
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: const AboutUsPage(),
                      type: PageTransitionType.rightToLeft,
                      childCurrent: const ProfilePage(),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInCubic));
                },
                child: Container(
                  width: double.maxFinite,
                  height: 55,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'About us',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right_outlined,
                              color: Colors.black.withOpacity(.6))
                        ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  AuthProvider.instance.signOut(context);
                  Navigator.of(context).push(PageTransition(
                      child: const LoginPage(),
                      type: PageTransitionType.bottomToTop,
                      childCurrent: const ProfilePage(),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInCubic));
                },
                child: Container(
                  width: double.maxFinite,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Sign Out',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.red),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
