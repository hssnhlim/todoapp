import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/auth.provider.dart';

class UDPage extends StatefulWidget {
  const UDPage({
    super.key,
    required this.documentSnapshot,
  });
  final DocumentSnapshot documentSnapshot;

  @override
  State<UDPage> createState() => _UDPageState();
}

class _UDPageState extends State<UDPage> {
  Future<dynamic> isDoneFunc() async {
    var uid =
        await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
    final docTL = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('time-line')
        .doc(widget.documentSnapshot.id);
    if (widget.documentSnapshot['isDone'] == false) {
      docTL.update({'isDone': true});
    } else {
      docTL.update({'isDone': false});
    }
    Navigator.of(context).pop();
  }

  Future<dynamic> deleteFunc() async {
    var uid =
        await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
    final docTL = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('time-line')
        .doc(widget.documentSnapshot.id);

    docTL.delete();
    Navigator.of(context).pop();
  }

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
                child: btnUD(
                    () => isDoneFunc(),
                    widget.documentSnapshot['isDone']
                        ? 'Mark as ToDo'
                        : 'Mark as Done',
                    widget.documentSnapshot['isDone']
                        ? Colors.transparent
                        : Colors.green.shade800,
                    widget.documentSnapshot['isDone']
                        ? Colors.black.withOpacity(.5)
                        : Colors.green.shade800,
                    Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: btnUD(() => deleteFunc(), 'Delete timeline',
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
