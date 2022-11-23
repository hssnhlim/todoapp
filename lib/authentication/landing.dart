import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/onboardpage.dart';

import '../Views/homepage.dart';
import 'auth.provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;
    if (user == null) {
      return const OnboardPage();
    } else {
      return const HomePage();
    }
  }
}
