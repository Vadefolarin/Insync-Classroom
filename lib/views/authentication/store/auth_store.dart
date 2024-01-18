import 'package:flutter/material.dart';
import 'package:insync/models/students/student_model.dart';
import 'package:insync/models/teachers/teacher_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  static const uid = "uid";
  static const firstName = "firstName";
  static const lastName = "lastName";
  static const email = "email";
  static const showOnboarding = "showOnboarding";
  static const isLoggedIn = "isLoggedIn";
  static const isStudent = "isStudent";
  static const isTeacher = "isTeacher";

  static final Future<SharedPreferences> authPref =
      SharedPreferences.getInstance();

  static Future<void> setTeacherstate(
    Teachermodel? user,
  ) async {
    final SharedPreferences prefs = await authPref;
    prefs.setString(AuthStore.uid, uid);
    prefs.setString(AuthStore.firstName, firstName);
    prefs.setString(AuthStore.lastName, lastName);
    prefs.setString(AuthStore.email, email);
  }

  static Future<void> setStudentstate(
    Studentmodel? user,
  ) async {
    final SharedPreferences prefs = await authPref;
    prefs.setString(AuthStore.uid, uid);
    prefs.setString(AuthStore.firstName, firstName);
    prefs.setString(AuthStore.lastName, lastName);
    prefs.setString(AuthStore.email, email);
  }

  static Future<Teachermodel> getCurrentTeacherData() async {
    final SharedPreferences prefs = await authPref;
    return Teachermodel.initial().copyWith(
      uid: prefs.getString(AuthStore.uid),
      firstName: prefs.getString(AuthStore.firstName),
      lastName: prefs.getString(AuthStore.lastName),
      email: prefs.getString(AuthStore.email),
    );
  }

  static Future<Studentmodel> getCurrentStudentData() async {
    final SharedPreferences prefs = await authPref;
    return Studentmodel.initial().copyWith(
      uid: prefs.getString(AuthStore.uid),
      firstName: prefs.getString(AuthStore.firstName),
      lastName: prefs.getString(AuthStore.lastName),
      email: prefs.getString(AuthStore.email),
    );
  }

  static Future setShowOnboarding(bool showOnboarding) async {
    return authPref.then((pref) {
      pref.setBool(AuthStore.showOnboarding, showOnboarding);
    });
  }

  static Future<bool> getShowOnboarding() {
    return authPref.then((pref) {
      return pref.getBool(AuthStore.showOnboarding) ?? true;
    });
  }

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    return authPref.then((pref) {
      pref.setBool(AuthStore.isLoggedIn, isLoggedIn);
    });
  }

  static Future<bool> getLoggedIn() {
    return authPref.then((pref) {
      return pref.getBool(AuthStore.isLoggedIn) ?? false;
    });
  }
}
