import 'dart:convert';

class Studentmodel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? deviceToken;
  final String? email;

  Studentmodel({
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

  Studentmodel.initial()
      : uid = '',
        firstName = '',
        lastName = '',
        deviceToken = '',
        email = '';

  factory Studentmodel.fromMap(Map<String, dynamic> map) {
    var data = Studentmodel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      deviceToken: map['deviceToken'],
      email: map['email'],
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

  factory Studentmodel.fromJson(String source) =>
      Studentmodel.fromMap(json.decode(source));

  Studentmodel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? deviceToken,
    String? email,
  }) {
    return Studentmodel(
      uid: uid ?? this.uid,
      firstName: firstName ?? firstName,
      lastName: lastName ?? lastName,
      deviceToken: deviceToken ?? deviceToken,
      email: email ?? email,
    );
  }
}
