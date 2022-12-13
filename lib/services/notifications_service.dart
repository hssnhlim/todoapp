import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzl;
import 'package:todoapp/models/timeline.model.dart';
// import 'package:timezone/standalone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    configureLocalTimezone();
    tzl.initializeTimeZones();
    tz.getLocation('America/Detroit');

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) =>
          selectNotification(details.toString()),
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      if (kDebugMode) {
        print('notification payload: $payload');
      }
    } else {
      if (kDebugMode) {
        print("Notification Done");
      }
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => HomePage()),
    // );
  }

  // immediate notification
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  // scheduled notification
  scheduledNotification(
      DateTime date, TimeOfDay time, Timeline timeline) async {
    var id = Random().nextInt(9999);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        timeline.topic,
        'Don\'t forget you have tasks todo!',
        _convertTime(date, time),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _convertTime(DateTime date, TimeOfDay time) {
    final tz.TZDateTime tzDate = tz.TZDateTime.from(date, tz.local);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, tzDate.year,
        tzDate.month, tzDate.day, time.hour, time.minute);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  Future<void> configureLocalTimezone() async {
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
