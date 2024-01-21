import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final localNotificationServiceProvider =
    Provider((ref) => LocalNotificationService());

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize(BuildContext context) async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    // TODO: change this to the app icon

    final DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveNotificationResponse,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: seconds)),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload, // The payload
  }) async {
    final details = await _notificationDetails();
    // Payload is a string that can be used to pass data to the notification
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  void onDidReceiveNotificationResponse(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    log('DrWho: onDidReceiveNotificationResponse id $id');
    log("DrWho: onDidReceiveNotificationResponse payload is here $payload");
  }

  // TODO: Consider how this will be used

  // void onSelectNotification(String payload) {
  //   print('payload $payload');
  //   if (payload != null && payload.isNotEmpty) {
  //     onNotificationClick.add(payload);
  //   }
  // }

  onSelectNotification(NotificationResponse notificationResponse) async {
    log("DrWho: payload is here ${notificationResponse.payload}");
    if (notificationResponse.payload != null &&
        notificationResponse.payload!.isNotEmpty) {
      var payloadData = jsonDecode(notificationResponse.payload!);
      onNotificationClick.add(payloadData);
    }
  }
}
