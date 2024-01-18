import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insync/views/authentication/store/auth_store.dart';
import 'package:insync/views/splashScreen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // var initializeApp = Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await initializeApp;
  final prefs = await SharedPreferences.getInstance();
  final pref = prefs.getBool('isLoggedIn') ?? false;
  final showOnboarding = await AuthStore.getShowOnboarding();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Insync Class',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
