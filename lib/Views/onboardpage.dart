import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/authentication/register.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: FadeInLeftBig(
                          duration: const Duration(milliseconds: 1400),
                          child: Image.asset('assets/images/Vector.png'))),
                  const SizedBox(
                    height: 60,
                  ),
                  FadeInLeftBig(
                    duration: const Duration(milliseconds: 1400),
                    child: Column(
                      children: const [
                        Text(
                          'To Do App',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'List all your important tasks without missing it.',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 122,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          delay: const Duration(milliseconds: 800),
                          child: ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('showHome', true);
                                Navigator.of(context).push(PageTransition(
                                    child: const RegisterPage(),
                                    type: PageTransitionType.bottomToTop,
                                    childCurrent: const OnboardPage(),
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeInCubic));
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(0, 54)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    letterSpacing: 1),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
