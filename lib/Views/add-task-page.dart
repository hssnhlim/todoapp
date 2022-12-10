import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/auth.provider.dart';
import 'package:todoapp/models/timeline.model.dart';
import 'package:todoapp/services/notifications_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
  });
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;

  final notifyHelper = NotifyHelper();

  @override
  void initState() {
    super.initState();
    notifyHelper.configureLocalTimezone();
  }

  DocumentReference uidRef = FirebaseFirestore.instance
      .collection('timeline')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  void dateOnTap() async {
    TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay.now());
    if (pickTime != null) {
      DateTime parsedTime =
          DateFormat.jm().parse(pickTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      String formattedTime = DateFormat().add_jm().format(parsedTime);
      setState(() {
        timeController.text = formattedTime;
//  DateFormat.yMMMMd().format(pickTime);
      });
    }
  }

  // String uidFunction(String uid) {
  //   // dart unique string generator
  //   String _randomString = uid.toString() +
  //       math.Random().nextInt(9999).toString() +
  //       math.Random().nextInt(9999).toString() +
  //       math.Random().nextInt(9999).toString();
  //   return _randomString;
  // }

  void addFunction() async {
    final uid =
        await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
    DocumentReference ref =
        db.collection('users').doc(uid).collection('time-line').doc();
    if (dateController.text.trim().isNotEmpty &&
        timeController.text.trim().isNotEmpty &&
        topicController.text.trim().isNotEmpty) {
      await db
          .collection('users')
          .doc(uid)
          .collection('time-line')
          .doc(ref.id)
          .set(Timeline(
                  id: ref.id, // auto generated id
                  date: dateController.text.trim(),
                  time: timeController.text.trim(),
                  topic: topicController.text.trim(),
                  isDone: false)
              .toJson());

      // notifyHelper.displayNotification(
      //     title: topicController.text.trim(), body: 'Don\'t forget your task!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'All fields required!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));
    }
    Navigator.of(context).pop();
  }

  void cancelAddFunction() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Add timeline 🗓️',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 1),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldDate(
                    dateController, 'Date', Icons.date_range_outlined),
                const SizedBox(
                  height: 20,
                ),
                textFieldTime(
                    timeController,
                    DateFormat.jm().format(DateTime.now()),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                    ),
                    dateOnTap),
                const SizedBox(
                  height: 20,
                ),
                textFieldTopic(
                    topicController,
                    'Topic',
                    const Icon(
                      Icons.topic_outlined,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          Expanded(child: Container()),
          btnSection()
        ],
      ),
    );
  }

  Widget textFieldDate(
    controller,
    hintText,
    icon,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: TextFormField(
        readOnly: true,
        cursorColor: Colors.black,
        style: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black),
        onTap: (() async {
          DateTime? pickDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(3000));
          if (pickDate != null) {
            setState(() {
              controller.text = DateFormat.yMMMMd().format(pickDate);
            });
          }
        }),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xff929292)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1))),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill the text field!';
          }
          return null;
        },
      ),
    );
  }

  Widget textFieldTime(controller, hintText, icon, dateOnTap) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: TextFormField(
        readOnly: true,
        cursorColor: Colors.black,
        style: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black),
        onTap: dateOnTap,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xff929292)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1))),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill the text field!';
          }
          return null;
        },
      ),
    );
  }

  Widget textFieldTopic(controller, hintText, icon) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: TextFormField(
        minLines: 1,
        maxLines: 3,
        cursorColor: Colors.black,
        style: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xff929292)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 1))),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill the text field!';
          }
          return null;
        },
      ),
    );
  }

  Widget btnAddTimeline(addFunction, text) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 200),
      child: ElevatedButton(
          onPressed: addFunction,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              fixedSize: MaterialStateProperty.all(const Size(0, 54)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 17,
                letterSpacing: 1),
          )),
    );
  }

  Widget btnCancelAddTimeline(cancelAddFunction, icon) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 200),
      child: ElevatedButton(
          onPressed: cancelAddFunction,
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black)),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              fixedSize: MaterialStateProperty.all(const Size(0, 54)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: Icon(
            icon,
            color: Colors.black,
          )),
    );
  }

  Widget btnSection() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: btnCancelAddTimeline(cancelAddFunction, Icons.clear)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 4, child: btnAddTimeline(addFunction, 'Add New Timeline'))
      ],
    );
  }
}
