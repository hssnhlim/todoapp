import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/onboardpage.dart';
import 'package:todoapp/authentication/login.dart';

import '../Views/homepage.dart';
import 'auth.provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;
    if (user == null) {
      return box.read('firstTime') == null
          ? const OnboardPage()
          : const LoginPage();
    } else {
      return const HomePage();
    }
  }
}
