import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insync/utils/colors.dart';
import 'package:insync/utils/utils.dart';
import 'package:insync/views/authentication/controllers/auth_controller.dart';
import 'package:insync/views/authentication/signUp/signUp.dart';
import 'package:insync/views/tutor/mainApp.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late ValueNotifier<bool> _currentIndexNotifier;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(false);

    super.initState();
  }

  @override
  void dispose() {
    passwordcontroller.dispose();
    emailController.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserIn() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Loader(),
          );
        },
      );
      try {
        // Sign-in successful, navigate to home screen
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        print("Email: ${prefs.getBool('isTutor').toString()}");

        bool isTutor = prefs.getBool('isTutor') ?? false;
        await ref.read(authControllerProvider).signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordcontroller.text,
              context: context,
              isTutor: isTutor ? true : false,
            );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainApp(
              isTutor: true,
            ),
          ),
          (route) => isTutor ? true : false,
        );
        prefs.setBool('isLoggedIn', isTutor);
      }
      
       on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Errorrrrrrrrrrrrr: $e');
        if (e.code.contains('The supplied auth credential is incorrect')) {
          toast('Incorect credentials');
          context.pop();
        } else if (e.code == "network-request-failed") {
          toast(
              "Network request failed. Please check your internet connection.");
          context.pop();
        } else if (e.code == "user-not-found") {
          toast("User not found !");
        } else if (e.code == "wrong-password") {
          toast("password is not correct !");
          context.pop();
        } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
          toast("invalid credentiels");
          context.pop();
        } else {
          toast("An error occurred. Please try again later.");
          context.pop();
        }
      }
    } 
       catch (e) {
        Navigator.pop(context);
        if (e.toString().contains('too many requests, try again later')) {
          showSnackBar(
              context, "Too many requests, try again later", MessageType.error);
        }
        loginInErrorMessage(null);
      }
    }
  }

  void loginInErrorMessage(String? errorMsg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              errorMsg ?? 'Incorrect login details',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcolorbackgrounddark,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndexNotifier,
          builder: (context, bool value, child) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/logo.png',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Continue Your learning  with Insync Classroom',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: kcolorMainPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InContainer(
                              color: value ? kcolorMainPrimary : Colors.white,
                              text: 'Login up as a Tutor',
                              icon: 'assets/icons/tutor.svg',
                              onTap: () {
                                print('--------------------');
                                _currentIndexNotifier.value =
                                    !_currentIndexNotifier.value;
                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //   return const SignUp();
                                // }));
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: InContainer(
                              color: !value ? kcolorMainPrimary : Colors.white,
                              text: 'Login up as a Student',
                              icon: 'assets/icons/student.svg',
                              onTap: () {
                                _currentIndexNotifier.value =
                                    !_currentIndexNotifier.value;
                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //   return const SignUp();
                                // }));
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),

                      // const ChooseAccount(),
                      const SizedBox(height: 50),
                      Text(
                        !value
                            ? 'Login with your FUTA Student email address'
                            : "Login with your Official Staff email  address",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: const Border.fromBorderSide(
                            BorderSide(color: Colors.white),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Type your email',
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/message.svg',
                              color: Colors.white,
                              fit: BoxFit.scaleDown,
                            ),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: const Border.fromBorderSide(
                            BorderSide(color: Colors.white),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: passwordcontroller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Type your password',
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/inputIcon.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          signUserIn();
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(
                          //     builder: (context) => const MainApp(
                          //       isTutor: false,
                          //     ),
                          //   ),
                          //   (route) => false,
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 32),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                Icon(Icons.check_circle_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Forgot password? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'click here',
                              style: TextStyle(
                                color: Color(0xFFC5D86D),
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
