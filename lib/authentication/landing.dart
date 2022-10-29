
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Views/homepage.dart';
import 'auth.provider.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;
    if(user==null){
      return LoginPage();
    }else
      {
        return HomePage();
      }
    return Container();
  }
}
