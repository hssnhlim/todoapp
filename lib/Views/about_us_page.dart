import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'About Us',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              heading1Text('Final Year Project: To Do App'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget heading1Text(String text) {
  return Text(text,
      style: const TextStyle(
          fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18));
}

Widget heading2Text(String text) {
  return Text(text,
      style: const TextStyle(
          fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 16));
}

Widget heading3Text(String text) {
  return Text(text,
      style: const TextStyle(
          fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 12));
}
