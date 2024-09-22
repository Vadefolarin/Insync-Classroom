// File: lib/screens/widgets/recent_activities_list.dart

import 'package:flutter/material.dart';
import 'package:insync/views/tutor/dashboard/home.dart';
import 'package:intl/intl.dart';

class RecentActivitiesList extends StatelessWidget {
  final List<Activity> activities;

  RecentActivitiesList({required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.map((activity) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(activity.studentAvatar),
          ),
          title: Text(
            '${activity.studentName} submitted ${activity.quizTitle}',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            DateFormat.yMMMd().add_jm().format(activity.submissionTime),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to Submission Details
          },
        );
      }).toList(),
    );
  }
}
