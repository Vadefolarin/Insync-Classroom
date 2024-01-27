import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  FutureOr<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
    required bool isTutor,
  }) async {
    try {
      var cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (isTutor == true) {
        await addNewTeacherToDatabase(cred.user!.uid).then((value) {
          Navigator.pop(context);
        });
      } else {
        await addNewStudentToDatabase(cred.user!.uid).then((value) {
          Navigator.pop(context);
        });
      }
    } on FirebaseAuthException catch (e) {}
  }

  FutureOr<void> signUserUp({
    required String email,
    required String password,
    required BuildContext context,
    required bool isTutor,
  }) async {
    try {
      var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User created${cred.user!.uid}');
      print('checktotor$isTutor');

      if (isTutor == true) {
        print('Tutor created${cred.user!.uid}');
        await addNewTeacherToDatabase(cred.user!.uid).then((value) {
          Navigator.pop(context);
        });
      } else {
        print('Student created${cred.user!.uid}');

        await addNewStudentToDatabase(cred.user!.uid).then((value) {
          Navigator.pop(context);
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == "Unable to establish connection on channel") {
        throw Exception('Unable to establish connection on channel');
      }
    } catch (e) {
      Navigator.pop(context);
      throw Exception(e.toString());
    }
  }

  FutureOr<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
    required bool isTutor,
  }) async {
// Teachermodel teachermodel = Teachermodel.initial().copyWith(
//   uid:
// );

    try {
      var cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (isTutor) {
        Teachermodel? teacher = await getCurrentTeacherData();
        if (teacher == null) {
          await addNewTeacherToDatabase(cred.user!.uid);
        }
      } else {
        Studentmodel? student = await getCurrentStudentData();
        if (student == null) {
          await addNewStudentToDatabase(cred.user!.uid);
        }
      }

      //TODO: Get Device Token 

      // await getDeviceToken();
    } on FirebaseAuthException catch (e) {}
  }

  FutureOr<Teachermodel?> getCurrentTeacherData() async {
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
      log("inSync: AuthService: getCurrentUserData: $e");
      throw Exception(e.toString());
    }
  }

  FutureOr<void> signOut() async {
    await auth.signOut();
  }

  // Get and save device token for firebase messaging
  Future<void> getCurrentTeacherToken() async {
    await firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      saveTeacherTokenToDatabase(token!);
    });
  }

  FutureOr<void> saveTeacherTokenToDatabase(String token) async {
    final uId = auth.currentUser!.uid;

    await firestore.collection('teachers').doc(uId).update({
      'deviceToken': token,
    });
    await firebaseMessaging.subscribeToTopic("teacherAnnouncements");
  }

  Future<void> getStudenDeviceToken() async {
    await firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      saveTeacherTokenToDatabase(token!);
    });
  }

  Future<void> saveStudentTokenToDatabase(String token) async {
    final uId = auth.currentUser!.uid;

    await firestore.collection('students').doc(uId).update({
      'deviceToken': token,
    });
    await firebaseMessaging.subscribeToTopic("studentAnnouncements");
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
      log("inSync: AuthService: getCurrentUserData: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> addNewTeacherToDatabase(String uid) async {
    var user = Teachermodel.initial();
    user = user.copyWith(uid: uid);

    await saveTeacherDataToFirebase(
      user: user,
    );

    // await getDeviceToken();
  }

  Future<void> addNewStudentToDatabase(String uid) async {
    // var currentUser = auth.currentUser;
    var user = Studentmodel.initial();
    user = user.copyWith(uid: uid);

    await saveStudentDataToFirebase(
      user: user,
    );
    // await getDeviceToken();
  }

  Future<bool> saveTeacherDataToFirebase({
    // File? profilePic,
    required Teachermodel user,
  }) async {
    print('before try...........................');
    try {
      if (user.firstName?.isEmpty ?? true) {
        print('.... ${user.firstName}');
        await firestore.collection('teachers').doc(user.uid).set(user.toMap());
      } else {
        print('.... +++++++++ ${user.firstName}');

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

  Future<bool> saveStudentDataToFirebase({
    // File? profilePic,
    required Studentmodel user,
  }) async {
    try {
      if (user.firstName?.isEmpty ?? true) {
        await firestore.collection('students').doc(user.uid).set(user.toMap());
      } else {
        var updateUser = user.copyWith(
          deviceToken: user.deviceToken,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          uid: user.uid,
        );

        await firestore
            .collection('students')
            .doc(user.uid)
            .update(updateUser.toMap());
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendResetEmail(String? email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email ?? auth.currentUser!.email!,
      );
    } catch (e) {
      print("inSync: sendResetEmail ${e.toString()}");
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
