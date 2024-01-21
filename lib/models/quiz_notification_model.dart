import 'dart:convert';

class QuizNotificationModel {
  final String teacherDeviceToken;
  final String teacherName;
  final String studentDeviceToken;
  final String studentName;
  final String studentUid;
  final int sentAt;

  QuizNotificationModel({
    required this.teacherDeviceToken,
    required this.teacherName,
    required this.studentDeviceToken,
    required this.studentName,
    required this.studentUid,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorDeviceToken': teacherDeviceToken,
      'doctorName': teacherName,
      'patientDeviceToken': studentDeviceToken,
      'patientUid': studentUid,
      'patientName': studentName,
      'sentAt': sentAt,
    };
  }

  factory QuizNotificationModel.fromMap(Map<String, dynamic> map) {
    return QuizNotificationModel(
      teacherDeviceToken: map['doctorDeviceToken'] ?? '',
      teacherName: map['doctorName'] ?? '',
      studentDeviceToken: map['patientDeviceToken'] ?? '',
      studentUid: map['patientUid'] ?? '',
      studentName: map['patientName'] ?? '',
      sentAt: map['sentAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizNotificationModel.fromJson(String source) =>
      QuizNotificationModel.fromMap(json.decode(source));
}
