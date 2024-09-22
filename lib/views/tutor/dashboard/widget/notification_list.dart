// File: lib/screens/widgets/notifications_list.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../home.dart';

class NotificationsList extends StatelessWidget {
  final List<NotificationItem> notifications;

  const NotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notification) {
        return ListTile(
          leading: const Icon(Icons.notification_important, color: Colors.orange),
          title: Text(notification.message),
          subtitle: Text(
            DateFormat.yMMMd().add_jm().format(notification.time),
            style: TextStyle(color: Colors.grey[600]),
          ),
          onTap: () {
            // Handle notification tap
          },
        );
      }).toList(),
    );
  }
}
