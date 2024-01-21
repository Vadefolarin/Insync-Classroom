import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/push_notification/services/local_notification_service.dart';
import 'package:rxdart/subjects.dart';


final localNotificationControllerProvider = Provider(
  (ref) => LocalNotificationController(
    localNotificationService: ref.watch(localNotificationServiceProvider),
    ref: ref,
  ),
);

class LocalNotificationController {
  final LocalNotificationService localNotificationService;
  final ProviderRef ref;

  LocalNotificationController({
    required this.localNotificationService,
    required this.ref,
  });

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize(BuildContext context) async {
    localNotificationService.initialize(context);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    localNotificationService.showNotification(
      id: id,
      title: title,
      body: body,
    );
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    localNotificationService.showScheduledNotification(
      id: id,
      title: title,
      body: body,
      seconds: 3,
    );
  }

  Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    localNotificationService.showNotificationWithPayload(
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }

  void onDidReceiveNotificationResponse(
      int id, String? title, String? body, String? payload) {}

  void onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
