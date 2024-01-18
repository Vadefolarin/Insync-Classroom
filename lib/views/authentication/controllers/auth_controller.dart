import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/models/students/student_model.dart';
import 'package:insync/models/teachers/teacher_model.dart';
import 'package:insync/services/auth_services.dart';
import 'package:insync/views/authentication/store/auth_store.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(
    authService: ref.watch(authServiceProvider),
    ref: ref,
  ),
);

// Use this to preload the initial teacher data from the local storage
final teacherDataProvider = FutureProvider<Teachermodel?>((ref) async {
  return await AuthStore.getCurrentTeacherData();
});

// Use this to preload the initial student data from the local storage
final studentDataProvider = FutureProvider<Studentmodel?>((ref) async {
  return await AuthStore.getCurrentStudentData();
});

// Use this after teacher data is loaded from the local storage to update the state.
final teacherStateProvider = StateProvider<Teachermodel?>((ref) => null);

final studentStateProvider = StateProvider<Studentmodel?>((ref) => null);

class AuthController {
  final AuthService authService;
  final ProviderRef ref;

  AuthController({required this.authService, required this.ref});

  Future<Teachermodel?> setTeacherState() async {
    Teachermodel? user = await getCurrentTeacherData();
    if (user != null) {
      await AuthStore.setTeacherstate(user);
      ref.read(teacherStateProvider.notifier).update((state) => user);
    }
    return user;
  }

  Future<Teachermodel?> getCurrentTeacherData() async {
    Teachermodel? user = await authService.getCurrentTeacherData();
    return user;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await authService.signInWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );
    await setTeacherState();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}
