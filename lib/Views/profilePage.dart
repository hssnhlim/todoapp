import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 122,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            user?.displayName ?? 'Username',
                            // user != null ? user.displayName! : "user",
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Tap to edit your profile',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_right_outlined))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'About Us',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.keyboard_arrow_right_outlined))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      AuthProvider.instance.signOut(context);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Sign Out',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.red),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
