import 'package:flutter/material.dart';
import 'package:insync/views/tutor/mainApp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    navigate(context, true);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // return const CreateQuizScreen(
      //   title: 'Create Quiz',
      // );
      //  return const SignUp();
      return const MainApp(
        isTutor: true,
      );
    }));
    // if (isLogin) {
    //   Navigator.p  ushNamed(context, '/home');
    // } else {
    //   Navigator.pushNamed(context, '/login');
    // }
  });
}
