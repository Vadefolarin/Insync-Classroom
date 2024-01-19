// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insync/utils/loader.dart';
import 'package:insync/utils/colors.dart';
import 'package:insync/utils/utils.dart';
import 'package:insync/views/authentication/controllers/auth_controller.dart';
import 'package:insync/views/authentication/login/login.dart';
import 'package:insync/views/tutor/mainApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  TextEditingController? emailcontroller;
  TextEditingController? controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? firstnamecontroller;

  TextEditingController? lastnamecontroller;

  TextEditingController? passwordcontroller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstnamecontroller?.dispose();
    lastnamecontroller?.dispose();
    controller?.dispose();
    passwordcontroller?.dispose();
    emailcontroller?.dispose();

    super.dispose();
  }

  // sign user in method
  void signUserUp() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: Loader(),
          );
        },
      );
      try {
        await ref.read(authControllerProvider).signUp(
              email: emailcontroller!.text,
              password: passwordcontroller!.text,
              context: context,
              //TODO: add a value notifier to listen if its tutuor or not
              isTutor: true
            );
        // print(
        //     'XXXXXXXXXXXXXXXXXXXXXXXXXXxx${widget.email} XXXXXXXXXXXXXXXXX ${passwordController.text}');
        // Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainApp(
              isTutor: true,
            ),
          ),
          (route) => false,
        );
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
      } catch (e) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ' Create your account and start using Insync Classroom',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kcolorMainPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // const ChooseAccount(),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'first name',
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
                                controller: firstnamecontroller,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: 'first name',
                                  prefixIcon: SvgPicture.asset(
                                    'assets/icons/name.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
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
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Last name',
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
                                controller: lastnamecontroller,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: 'Last name',
                                  prefixIcon: SvgPicture.asset(
                                    'assets/icons/name.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
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
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Registered email address or Matric number',
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
                      controller: emailcontroller,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Type your email',
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/message.svg',
                          fit: BoxFit.scaleDown,
                          color: Colors.white,
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
                        } else if (!value.contains('.')) {
                          return 'Please enter a valid email';
                        } else if (value.contains(' ')) {
                          return 'Please enter a valid email';
                        } else if (value.contains('..')) {
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
                        } else if (value.length < 4) {
                          return 'Password must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 35),
                  InkWell(
                    onTap: () {
                      signUserUp();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return const MainApp(
                      //         isTutor: true,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 32),
                      child: const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.check_circle_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Login();
                            },
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





class InContainer extends StatelessWidget {
  const InContainer({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    required this.color,
  });
  final String text;
  final String icon;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF333333),
          borderRadius: BorderRadius.circular(10),
          //TODO: change color ONTAP
          border: Border.all(color: color, width: 4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 21),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
              height: 25,
              width: 25,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
