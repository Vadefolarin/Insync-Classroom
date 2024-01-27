import 'dart:convert';

class Teachermodel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? deviceToken;
  final String? email;

  Teachermodel({
    this.uid,
    this.firstName,
    this.lastName,
    this.deviceToken,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'deviceToken': deviceToken,
    };
  }

  Teachermodel.initial()
      : uid = '',
        firstName = '',
        lastName = '',
        deviceToken = '',
        email = '';

  factory Teachermodel.fromMap(Map<String, dynamic> map) {
    var data = Teachermodel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      email: map['email'] ?? '',
    );
    return data;
    //  Teachermodel(
    //   uid: map['uid'],
    //   firstName: map['firstName'],
    //   lastName: map['lastName'],
    //   deviceToken: map['deviceToken'],
    // );
  }
  String toJson() => json.encode(toMap());

  factory Teachermodel.fromJson(String source) =>
      Teachermodel.fromMap(json.decode(source));

  Teachermodel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? deviceToken,
    String? email,
  }) {
    return Teachermodel(
      uid: uid ?? this.uid,
      firstName: firstName ?? firstName,
      lastName: lastName ?? lastName,
      deviceToken: deviceToken ?? deviceToken,
      email: email ?? email,
    );
  }
}
