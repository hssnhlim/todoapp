import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/add-task-page.dart';
import 'package:todoapp/Views/update_delete_page.dart';
import 'package:todoapp/authentication/auth.provider.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  DateTime currentDate = DateTime.now();

  DocumentReference uidRef = FirebaseFirestore.instance
      .collection('timeline')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final CollectionReference _timeline =
      FirebaseFirestore.instance.collection('timeline');

  bool isCompleted = false;

  Future<dynamic> udFunction() {
    return showModalBottomSheet(
        constraints: BoxConstraints.tight(const Size(double.maxFinite, 240)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) => const UDPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 0,
          toolbarHeight: 70,
          title: const Text(
            'Timeline',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 35,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                child: FadeInRight(
                  duration: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Container(
                      color: const Color(0xffF3F3F3),
                      child: DatePicker(
                        DateTime.now(),
                        height: 100,
                        width: 80,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors
                            .primaries[
                                Random().nextInt(Colors.primaries.length)]
                            .shade200,
                        selectedTextColor: Colors.black,
                        dateTextStyle: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.grey),
                        dayTextStyle: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.grey),
                        monthTextStyle: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.grey),
                        onDateChange: (selectedDate) {
                          setState(() {
                            currentDate = selectedDate;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: getUsersTimelineSnapshots(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: FadeInUp(
                                  duration: const Duration(milliseconds: 500),
                                  child: ListTile(
                                    onLongPress: () => udFunction(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    tileColor: Colors
                                        .primaries[Random()
                                            .nextInt(Colors.primaries.length)]
                                        .shade200,
                                    title: Text(
                                      documentSnapshot['topic'],
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      documentSnapshot['time'],
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(.6)),
                                    ),
                                    trailing: RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        documentSnapshot['isDone']
                                            ? 'Done'
                                            : 'ToDo',
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: documentSnapshot['isDone']
                                                ? Colors.green.shade800
                                                : Colors.black.withOpacity(.5)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
        floatingActionButton: FadeInRight(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          child: FloatingActionButton.extended(
            label: const Text(
              'Add Timeline',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  letterSpacing: 1),
            ),
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onPressed: () {
              showModalBottomSheet(
                  // isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  context: context,
                  builder: (context) => const AddTaskPage());
            },
          ),
        ));
  }

  // _widgetDatePicker() {
  //   return SizedBox(
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10, top: 20),
  //       child: FadeInRight(
  //         duration: const Duration(milliseconds: 600),
  //         child: DatePicker(
  //           DateTime.now(),
  //           height: 100,
  //           width: 80,
  //           initialSelectedDate: DateTime.now(),
  //           selectionColor: Colors.white,
  //           selectedTextColor: Colors.black,
  //           dateTextStyle: const TextStyle(
  //               fontFamily: 'poppins',
  //               fontWeight: FontWeight.w600,
  //               fontSize: 20,
  //               color: Colors.grey),
  //           dayTextStyle: const TextStyle(
  //               fontFamily: 'poppins',
  //               fontWeight: FontWeight.w400,
  //               fontSize: 11,
  //               color: Colors.grey),
  //           monthTextStyle: const TextStyle(
  //               fontFamily: 'poppins',
  //               fontWeight: FontWeight.w400,
  //               fontSize: 11,
  //               color: Colors.grey),
  //           onDateChange: (selectedDate) {
  //             setState(() {
  //               _selectedDate = selectedDate;
  //             });
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Stream<QuerySnapshot> getUsersTimelineSnapshots(BuildContext context) async* {
  final uid =
      await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
  yield* FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('time-line')
      .snapshots();
}
