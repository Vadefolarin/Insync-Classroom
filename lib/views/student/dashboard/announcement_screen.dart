import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  // Sample list of notifications
  final List<Map<String, String>> notifications = [
    {
      "title": "New Video Uploaded",
      "description":
          "A new video on Algebra has been uploaded by your teacher.",
      "time": "2 hours ago",
      "type": "video"
    },
    {
      "title": "Reminder",
      "description": "Dnt forget to view the video on Calculus.",
      "time": "1 day ago",
      "type": "update"
    },
    {
      "title": "New PDF Material",
      "description": "Your teacher has uploaded a new PDF on Operating System.",
      "time": "3 days ago",
      "type": "file"
    },
  ];

  AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Announcements",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return _buildNotificationCard(notification);
          },
        ),
      ),
    );
  }

  // Build notification card widget
  Widget _buildNotificationCard(Map<String, String> notification) {
    IconData icon;
    Color iconColor;

    // Assign different icons and colors based on notification type
    switch (notification['type']) {
      case 'video':
        icon = Icons.videocam;
        iconColor = Colors.blue;
        break;
      case 'file':
        icon = Icons.insert_drive_file;
        iconColor = Colors.green;
        break;
      case 'assignment':
        icon = Icons.assignment;
        iconColor = Colors.orange;
        break;
      case 'update':
        icon = Icons.update;
        iconColor = Colors.purple;
        break;
      default:
        icon = Icons.notifications;
        iconColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
        title: Text(
          notification['title']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              notification['description']!,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 5),
            Text(
              notification['time']!,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: () {
          // Handle tap to view notification details (if needed)
          print("Notification clicked: ${notification['title']}");
        },
      ),
    );
  }
}
