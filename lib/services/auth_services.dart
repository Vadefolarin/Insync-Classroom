import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/models/students/student_model.dart';
import 'package:insync/models/teachers/teacher_model.dart';
import 'package:insync/views/authentication/store/auth_store.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    firebaseMessaging: FirebaseMessaging.instance,
    ref: ref,
  ),
);

class AuthService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseMessaging firebaseMessaging;
  final ProviderRef ref;

  AuthService({
    required this.auth,
    required this.firestore,
    required this.firebaseMessaging,
    required this.ref,
  });

  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
// Teachermodel teachermodel = Teachermodel.initial().copyWith(
//   uid:
// );

    try {
      var cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Teachermodel? teacher = await getCurrentTeacherData();
      if (teacher == null) {
        // Add new user to the patient collection
        await addNewTeacherToDatabase(cred.user!.uid);
      }
      await getDeviceToken();
    } on FirebaseAuthException catch (e) {}
  }

  Future<Teachermodel?> getCurrentTeacherData() async {
    try {
      var user = auth.currentUser;
      if (user != null) {
        var userData =
            await firestore.collection('teachers').doc(user.uid).get();
        if (userData.exists) {
          return Teachermodel.fromMap(userData.data()!);
        }
      }
      return null;
    } catch (e) {
      log("DrWho: AuthService: getCurrentUserData: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  // Get and save device token for firebase messaging
  Future<void> getDeviceToken() async {
    await firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      saveTeacherToDatabase(token!);
    });
  }

  Future<void> saveTeacherToDatabase(String token) async {
    final uId = auth.currentUser!.uid;

    await firestore.collection('teacher').doc(uId).update({
      'deviceToken': token,
    });
    await firebaseMessaging.subscribeToTopic("teacherAnnouncements");
  }

  Future<Studentmodel?> getCurrentStudentData() async {
    try {
      var user = auth.currentUser;
      if (user != null) {
        var userData =
            await firestore.collection('teachers').doc(user.uid).get();
        if (userData.exists) {
          return Studentmodel.fromMap(userData.data()!);
        }
      }
      return null;
    } catch (e) {
      log("DrWho: AuthService: getCurrentUserData: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> addNewTeacherToDatabase(String uid) async {
    var currentUser = auth.currentUser;
    Teachermodel user = Teachermodel.initial().copyWith(
      uid: uid,
      email: currentUser != null ? currentUser.email : "",
    );
    try {
      await saveTeacherDataToFirebase(
        user: user,
      );
    } catch (e) {
      log("DrWho: AuthService: addNewUserToDatabase: $e");
      throw Exception(e.toString());
    }
  }

  Future<bool> saveTeacherDataToFirebase({
    // File? profilePic,
    required Teachermodel user,
  }) async {
    try {
      if (user.firstName == '') {
        await firestore.collection('teacher').doc(user.uid).set(user.toMap());
      } else {
        var updateUser = user.copyWith(
          deviceToken: user.deviceToken,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          uid: user.uid,
        );

        await firestore
            .collection('teachers')
            .doc(user.uid)
            .update(updateUser.toMap());
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class TeacherStateNotifier extends StateNotifier<Teachermodel> {
  TeacherStateNotifier() : super(Teachermodel.initial());

  Future<void> updateUser(Teachermodel updatedUser) async {
    state = updatedUser;
    await AuthStore.setTeacherstate(state);
  }
}

class StudentStateNotifier extends StateNotifier<Studentmodel> {
  StudentStateNotifier() : super(Studentmodel.initial());

  Future<void> updateUser(Studentmodel updatedUser) async {
    state = updatedUser;
    await AuthStore.setStudentstate(state);
  }
}

final teacherProvider =
    StateNotifierProvider<TeacherStateNotifier, Teachermodel>((ref) {
  return TeacherStateNotifier();
});
final studentProvider =
    StateNotifierProvider<StudentStateNotifier, Studentmodel>((ref) {
  return StudentStateNotifier();
});
