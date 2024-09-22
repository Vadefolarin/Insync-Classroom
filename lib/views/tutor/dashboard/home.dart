// File: lib/screens/dashboard_screen.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widget/notification_list.dart';
import 'widget/performance_metric.dart';
import 'widget/quick_action.dart';
import 'widget/recent_student_activity.dart';
import 'widget/section_tile.dart';
import 'widget/upcoming_deadline.dart';
import 'widget/welcome_header.dart';

class HomeScreen extends StatelessWidget {
  // Mock Data
  final String teacherName = "Mr. Smith";
  final String profileImageUrl =
      "https://www.w3schools.com/howto/img_avatar.png"; // Placeholder image

  final List<Quiz> upcomingQuizzes = [
    Quiz(title: "Math Quiz 1", deadline: DateTime.now().add(const Duration(days: 2))),
    Quiz(title: "Science Quiz 2", deadline: DateTime.now().add(const Duration(days: 5))),
    Quiz(title: "History Quiz 3", deadline: DateTime.now().add(const Duration(days: 7))),
  ];

  final List<Activity> recentActivities = [
    Activity(
      studentName: "John Doe",
      quizTitle: "Math Quiz 1",
      submissionTime: DateTime.now().subtract(const Duration(hours: 2)),
      studentAvatar:
          "https://www.w3schools.com/howto/img_avatar.png", // Placeholder avatar
    ),
    Activity(
      studentName: "Jane Smith",
      quizTitle: "Science Quiz 2",
      submissionTime: DateTime.now().subtract(const Duration(hours: 5)),
      studentAvatar:
          "https://www.w3schools.com/howto/img_avatar2.png", // Placeholder avatar
    ),
    // Add more activities as needed
  ];

  final List<NotificationItem> notifications = [
    NotificationItem(
      message: "New student John Doe joined the class.",
      time: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    NotificationItem(
      message: "Math Quiz 1 is due in 2 days.",
      time: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    // Add more notifications as needed
  ];

  final List<BarChartGroupData> performanceData = [
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(
        fromY: 80,
        toY: 100,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    ]),
     BarChartGroupData(x: 2, barRods: [
      BarChartRodData(
        fromY: 90,
        toY: 100,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    ]),
      BarChartGroupData(x: 3, barRods: [
      BarChartRodData(
        fromY: 70,
        toY: 100,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    ]),
        BarChartGroupData(x: 4, barRods: [
      BarChartRodData(
        fromY: 85,
        toY: 100,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    ]),
         BarChartGroupData(x: 5, barRods: [
      BarChartRodData(
        fromY: 100,
        toY: 75,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    ]),
    
    // BarChartGroupData(x: 2, barRods: [
    //   BarChartRodData(y: 90, colors: [Colors.blue])
    // ]),
    // BarChartGroupData(x: 3, barRods: [
    //   BarChartRodData(y: 70, colors: [Colors.blue])
    // ]),
    // BarChartGroupData(x: 4, barRods: [
    //   BarChartRodData(y: 85, colors: [Colors.blue])
    // ]),
    // BarChartGroupData(x: 5, barRods: [
    //   BarChartRodData(y: 75, colors: [Colors.blue])
    // ]),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional AppBar
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement pull-to-refresh functionality here
          // For now, we just wait for a second
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              WelcomeHeader(
                teacherName: teacherName,
                profileImageUrl: profileImageUrl,
              ),
              const SizedBox(height: 16),

              // Quick Actions
              QuickActions(),
              const SizedBox(height: 24),

              // Upcoming Deadlines
              SectionTitle(title: "Upcoming Deadlines"),
              const SizedBox(height: 8),
              UpcomingDeadlinesList(quizzes: upcomingQuizzes),
              const SizedBox(height: 24),

              // Recent Student Activity
              SectionTitle(title: "Recent Student Activity"),
              const SizedBox(height: 8),
              RecentActivitiesList(activities: recentActivities),
              const SizedBox(height: 24),

              // Performance Metrics
              SectionTitle(title: "Performance Metrics"),
              const SizedBox(height: 8),
              PerformanceMetricsChart(data: performanceData),
              const SizedBox(height: 24),

              // Notifications
              SectionTitle(title: "Notifications"),
              const SizedBox(height: 8),
              NotificationsList(notifications: notifications),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Data Models
class Quiz {
  final String title;
  final DateTime deadline;

  Quiz({required this.title, required this.deadline});
}

class Activity {
  final String studentName;
  final String quizTitle;
  final DateTime submissionTime;
  final String studentAvatar;

  Activity({
    required this.studentName,
    required this.quizTitle,
    required this.submissionTime,
    required this.studentAvatar,
  });
}

class NotificationItem {
  final String message;
  final DateTime time;

  NotificationItem({required this.message, required this.time});
}
