import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class UDPage extends StatefulWidget {
  const UDPage({super.key});

  @override
  State<UDPage> createState() => _UDPageState();
}

class _UDPageState extends State<UDPage> {
  void doneFunction() {}

  void deleteFunction() {}

  void cancelFunction() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: btnUD(doneFunction, 'Mark as Done',
                    Colors.green.shade800, Colors.green.shade800, Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: btnUD(deleteFunction, 'Delete timeline',
                    Colors.red.shade800, Colors.red.shade800, Colors.white),
              )
            ],
          ),
          Expanded(child: Container()),
          Row(
            children: [
              Expanded(
                child: btnUD(cancelFunction, 'Cancel', Colors.black,
                    Colors.white, Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget btnUD(function, text, color, bColor, textColor) {
    return ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(color: color)),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(bColor),
            fixedSize: MaterialStateProperty.all(const Size(0, 49)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w400,
              fontSize: 17,
              letterSpacing: 1),
        ));
  }
}
