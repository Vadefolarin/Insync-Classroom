// File: lib/screens/widgets/upcoming_deadlines_list.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insync/views/tutor/dashboard/home.dart';
import 'package:intl/intl.dart';

class UpcomingDeadlinesList extends StatelessWidget {
  final List<Quiz> quizzes;

  UpcomingDeadlinesList({required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: quizzes.map((quiz) {
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(Icons.assignment, color: Colors.blue),
            title: Text(
              quiz.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Due: ${DateFormat.yMMMd().add_jm().format(quiz.deadline)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            trailing: CountdownTimer(endTime: quiz.deadline),
            onTap: () {
              // Navigate to Quiz Details
            },
          ),
        );
      }).toList(),
    );
  }
}

// Countdown Timer Widget
class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  CountdownTimer({required this.endTime});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remaining;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.endTime.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remaining = widget.endTime.difference(DateTime.now());
        if (remaining.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timeLeft {
    if (remaining.isNegative) {
      return "Expired";
    } else {
      return "${remaining.inDays}d ${remaining.inHours % 24}h left";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeLeft,
      style: TextStyle(
        color: remaining.isNegative ? Colors.red : Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
