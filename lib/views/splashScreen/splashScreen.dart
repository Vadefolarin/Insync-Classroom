import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insync/views/authentication/login/login.dart';
import 'package:insync/views/onboarding/onboarding.dart';
import 'package:insync/views/tutor/mainApp.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  User? user;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    Timer(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
    super.initState();
  }

  void _checkLoginStatus() async {
    // await Future.delayed(); // Simulate a delay for splash screen
    User? user = FirebaseAuth.instance.currentUser;
    print('User: $user');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Email: ${prefs.getBool('isTutor').toString()}");

    if (user == null) {
      // User is not logged in, navigate to SignIn screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Onboarding()),
      );
    } else if (prefs.getBool('isTutor') == true) {
      // User if its a tutor, navigate to tutor screen else navigate to student screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainApp(isTutor: true),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainApp(isTutor: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: AnimatedScrollView(
            listAnimationType: ListAnimationType.Scale,
            scaleConfiguration:
                ScaleConfiguration(duration: const Duration(seconds: 3)),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              const Text(
                'Insync Classroom',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void navigate(BuildContext context, bool isLogin) {
  Future.delayed(const Duration(seconds: 4)).then((value) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   // return const CreateQuizScreen(
    //   //   title: 'Create Quiz',
    //   // );
    //   //  return const SignUp();
    //   // return const MainApp(
    //   //   isTutor: true,
    //   // );
    // }));
    if (isLogin) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MainApp(
          isTutor: true,
        );
      }));
      // Navigator.pushNamed(context, '/home');
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Login();
      }));
    }
  });
}
