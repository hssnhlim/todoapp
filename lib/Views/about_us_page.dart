import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: const Text(
            'About Us',
            style:
                TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                container(Column(
                  children: [
                    heading1Text('Final Year Project: To Do App'),
                    heading3Text(
                      'Developed by: Muhammad Hassan',
                    ),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                container(heading2Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                )),
                const SizedBox(
                  height: 20,
                ),
                container(heading2Text(
                    'vitae turpis massa sed elementum tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse in est ante in nibh mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit amet nulla facilisi morbi tempus iaculis urna id volutpat lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus quis varius quam quisque id diam vel quam elementum pulvinar etiam non quam lacus suspendisse'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget container(Widget anything) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(.8),
            blurRadius: 7,
            offset: const Offset(0, 3),
            spreadRadius: 0)
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: anything,
    ),
  );
}

Widget heading1Text(String text) {
  return Text(text,
      style: const TextStyle(
          fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 20));
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
