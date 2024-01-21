import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:insync/const.dart';
import 'package:insync/models/quiz_notification_model.dart';
import 'package:insync/push_notification/controllers/local_notification_controller.dart';
import 'package:insync/services/auth_services.dart';
import 'package:insync/views/authentication/controllers/auth_controller.dart';
import 'package:insync/views/student/quizzes/quizzes.dart';

var consultationExpirationTime = 5000;

final pushNotificationServiceProvider = Provider<PushNotificationService>(
  (ref) => PushNotificationService(
    authService: ref.watch(authServiceProvider),
    firestore: FirebaseFirestore.instance,
    firebaseMessaging: FirebaseMessaging.instance,
    ref: ref,
  ),
);

class PushNotificationService {
  final AuthService authService;
  final FirebaseFirestore firestore;
  final FirebaseMessaging firebaseMessaging;
  final ProviderRef ref;

  PushNotificationService({
    required this.authService,
    required this.firestore,
    required this.firebaseMessaging,
    required this.ref,
  });

  Future<void> init(BuildContext context) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('DrWho: User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('DrWho: User granted provisional permission');
    } else {
      log('DrWho: User declined or has not accepted permission');
    }
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    void handleMessage(RemoteMessage message) {
      handleMessageResponse(message, context);
    }

    if (initialMessage != null) {
      handleMessage(initialMessage);
      log('DrWho: Message caused app to open from terminated state: $initialMessage');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('DrWho: Got a message whilst in the foreground!');
      handleMessageResponse(message, context);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('DrWho: Message caused app to open from background state: $message');
      handleMessageResponse(message, context);
    });

    await getDeviceToken();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('DrWho: Handling a background message ${message.messageId}');
    var mTitle = message.notification?.title ?? "DrWho alert";
    var mBody = message.notification?.body ?? "DrWho alert";
    ref.read(localNotificationControllerProvider).showNotification(
          id: 0,
          title: mTitle.toString(),
          body: mBody.toString(),
        );
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
  }

  Future<bool> sendPushNotification({
    required String body,
    required String type, // use PushNotificationTypes
  }) async {
    try {
      var student = ref.read(studentStateProvider);
      var teacher = ref.read(teacherStateProvider);
      if (student == null || teacher == null) {
        return false;
      }
      QuizNotificationModel notifyData = QuizNotificationModel(
        studentName: student.firstName ?? '',
        studentUid: student.uid ?? '',
        studentDeviceToken: student.deviceToken ?? '',
        teacherDeviceToken: teacher.deviceToken ?? '',
        teacherName: teacher.lastName ?? '',
        sentAt: DateTime.now().microsecondsSinceEpoch,
      );
      const postUrl = 'https://fcm.googleapis.com/fcm/send';
      final data = {
        "to": notifyData.teacherDeviceToken,
        "notification": {
          "title": "New Quiz alert",
          "body": body,
        },
        "priority": "high",
        "data": {
          "type": type,
          "click_action": 'FLUTTER_NOTIFICATION_CLICK',
          "status": "done",
          "body": notifyData.toJson(),
          "title": "Consultation request",
        }
      };
      // TODO: make sure this si not hardcoded and not my private key
      final headers = {
        'content-type': 'application/json',
        'Authorization':
            "key=AAAAo1oqtzg:APA91bHn3JSDkMj_SqnYnKhp4_7pwrR9Ik85OG8DrN7hfMUB2KHyx8KFA8Xsq6CoJP0N0l8tmF7Kxkh_W8FNF8pbzruPKR2JnIoTh5SyNOLoImAMaP1TXdE329zHLWrdIg3IBZENU3x5",
      };

      final response = await http.post(
        Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("InSyncLog: sendPushNotification $e");
      throw Exception(e);
    }
  }

  Future<void> handleMessageResponse(
    RemoteMessage message,
    BuildContext context,
  ) async {
    // This function is called when the user clicks on the notification
    try {
      var currentStudent = ref.read(studentStateProvider);
      if (message.data["type"] == PushNotificationTypes.quizAccepted) {
        //TODO: Deduct the consultation token from the patient
        if (currentStudent == null) {
          return;
        }
        // Navigate to Student  Quiz Screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const StudentQuizzes();
            },
          ),
        );
      }
      // } else if (currentStudent != null &&
      //     message.data["type"] ==
      //         PushNotificationTypes.consultationVideoEnded) {
      //   // TODO: handel video call ended
      // } else if (message.data["type"] == PushNotificationTypes.callDeclined) {
      //   Navigator.of(context).pop();
      //   showSnackBar(context, "Call declined", MessageType.info);
      // } else if (message.data["type"] ==
      //     PushNotificationTypes.consultationEnded) {
      //   showSnackBar(context, "Consultation ended", MessageType.info);
      //   Navigator.pushReplacementNamed(context, AppBottomNavbar.routeName);
      //   // TODO: show dialog to rate the doctor??
      //   // TODO: could Navigate to review
      //   // TODO: clear current doctor
      // } else if (message.data["type"] ==
      //     PushNotificationTypes.consultationRejected) {
      //   showSnackBar(context, "Doctor currently unavailable", MessageType.info);
      //   Navigator.popUntil(context, (route) => route.isFirst);
      // }
    } catch (e) {
      log("DrWhoLog: handleMessageResponse $e");
    }
  }

  // TODO: handle multiple device login, update device token
  Future<void> getDeviceToken() async {
    await firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      saveTokenToDatabase(token!);
    });
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    var data = await authService.getCurrentStudentData();

    await FirebaseFirestore.instance
        .collection('students')
        .doc(data!.uid)
        .update({
      'deviceToken': token,
    });
    await firebaseMessaging.subscribeToTopic("teacherAnnouncements");
  }
}
