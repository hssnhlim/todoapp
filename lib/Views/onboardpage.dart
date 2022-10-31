import 'package:flutter/material.dart';
import 'package:todoapp/authentication/login.dart';
import 'package:todoapp/authentication/register.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Vector.png'),
              SizedBox(
                height: 60,
              ),
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
              SizedBox(
                height: 122,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        letterSpacing: 1),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      fixedSize: MaterialStateProperty.all(Size(335, 54)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))))
            ],
          ),
        ),
      ),
    ));
  }
}
