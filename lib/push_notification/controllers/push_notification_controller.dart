import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/push_notification/services/push_notification_service.dart';

final pushNotificationController = Provider(
  (ref) => PushNotificationController(
    pushNotificationService: ref.watch(pushNotificationServiceProvider),
    ref: ref,
  ),
);

class PushNotificationController {
  final PushNotificationService pushNotificationService;
  final ProviderRef ref;

  PushNotificationController({
    required this.pushNotificationService,
    required this.ref,
  });

  Future<void> init(BuildContext context) async {
    await pushNotificationService.init(context);
  }

  Future<bool> sendPushNotification({
    required String body,
    required String type,
  }) async {
    return await pushNotificationService.sendPushNotification(
      body: body,
      type: type,
    );
  }
}
