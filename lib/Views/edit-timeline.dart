import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/auth.provider.dart';
import 'package:todoapp/models/timeline.model.dart';
import 'package:todoapp/services/notifications_service.dart';

class EditTimeline extends StatefulWidget {
  const EditTimeline({
    super.key,
    required this.documentSnapshot,
  });
  final DocumentSnapshot documentSnapshot;

  @override
  State<EditTimeline> createState() => _EditTimelineState();
}

class _EditTimelineState extends State<EditTimeline> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;

  final notifyHelper = NotifyHelper();

  var now = DateTime.now();

  TimeOfDay? time;
  DateTime? date;

  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void dateOnTap() async {
    var now = TimeOfDay.now();
    TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute + 1));
    if (pickTime != null) {
      DateTime parsedTime =
          DateFormat.jm().parse(pickTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      setState(() {
        time = pickTime;
        timeController.text = formattedTime;
//  DateFormat.yMMMMd().format(pickTime);
      });
    }
  }

  void updateFunction() async {
    final uid =
        await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();

    var timeline = Timeline(
        id: widget.documentSnapshot.id, // auto generated id
        date: dateController.text.trim(),
        time: timeController.text.trim(),
        topic: topicController.text.trim(),
        isDone: false);

    if (dateController.text.trim().isNotEmpty ||
        timeController.text.trim().isNotEmpty ||
        topicController.text.trim().isNotEmpty) {
      await db
          .collection('users')
          .doc(uid)
          .collection('time-line')
          .doc(widget.documentSnapshot.id)
          .set(
              Timeline(
                      id: widget.documentSnapshot.id,
                      date: dateController.text.trim().isNotEmpty
                          ? dateController.text.trim()
                          : widget.documentSnapshot['date'],
                      time: timeController.text.trim().isNotEmpty
                          ? timeController.text.trim()
                          : widget.documentSnapshot['time'],
                      topic: topicController.text.trim().isNotEmpty
                          ? topicController.text.trim()
                          : widget.documentSnapshot['topic'],
                      isDone: widget.documentSnapshot['isDone'])
                  .toJson(),
              SetOptions(merge: true));
    }

    if (date != currentDate) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        date != null
            ? 'We will remind you on $date'
            : 'We will remind you on the same date',
        style:
            const TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));
    } else {
      // var currDate = dateController.text.split(' ');
      // var year = currDate[2];
      // var day = currDate[1].toString().replaceAll(',', '');
      // var month = getMonth(currDate[0]);
      // var acceptString = "$year-$month-$day";
      // var docDate = DateTime.parse(acceptString);
      // print('docDate: $docDate');
      // print('CurrentDate: $currentDate');
      // print('Time: $time');
      // print('date: $date');

      notifyHelper.scheduledNotification(date!, time!, timeline);
    }

    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  void cancelUpdateFunction() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
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
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldDate(dateController, widget.documentSnapshot['date'],
                    Icons.date_range_outlined),
                const SizedBox(
                  height: 20,
                ),
                textFieldTime(
                    timeController,
                    widget.documentSnapshot['time'],
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
                    widget.documentSnapshot['topic'],
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
          var now = DateTime.now();
          DateTime? pickDate = await showDatePicker(
              context: context,
              initialDate: DateTime(
                  now.year, now.month, now.day, now.hour, now.minute + 1),
              firstDate: DateTime(2000),
              lastDate: DateTime(3000));
          if (pickDate != null) {
            setState(() {
              date = pickDate;
              controller.text = DateFormat.yMMMMd().format(pickDate);
            });
          } else {
            setState(() {
              date = widget.documentSnapshot['date'] as DateTime;
              controller.text = DateFormat.yMMMMd().format(date!);
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
        maxLines: 4,
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

  Widget btnUpdateTimeline(addFunction, text) {
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

  Widget btnCancelUpdateTimeline(cancelAddFunction, icon) {
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
            child: btnCancelUpdateTimeline(cancelUpdateFunction, Icons.clear)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 4,
            child: btnUpdateTimeline(updateFunction, 'Update Timeline'))
      ],
    );
  }

  getMonth(String date) {
    //todo:do for all month
    if (date == 'December') {
      return 12;
    } else if (date == 'January') {
      return 1;
    }
  }
}
