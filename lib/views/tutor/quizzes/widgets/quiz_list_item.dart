// File: lib/widgets/quiz_list_item.dart

// Countdown Timer Widget (reused from previous code)
import 'dart:async';
import '../../../../models/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuizListItem extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onTap;

  const QuizListItem({super.key, required this.quiz, required this.onTap});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isUpcoming = quiz.deadline.isAfter(now);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          isUpcoming ? Icons.assignment : Icons.assignment_turned_in,
          color: isUpcoming ? Colors.blue : Colors.grey,
          size: 40,
        ),
        title: Text(
          quiz.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Deadline: ${DateFormat.yMMMd().add_jm().format(quiz.deadline)}',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        trailing: isUpcoming
            ? CountdownTimer(endTime: quiz.deadline)
            : const Icon(Icons.check_circle, color: Colors.green),
        onTap: onTap,
      ),
    );
  }
}



class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimer({super.key, required this.endTime});

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      int days = remaining.inDays;
      int hours = remaining.inHours % 24;
      int minutes = remaining.inMinutes % 60;
      return "${days}d ${hours}h ${minutes}m left";
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
