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
// https://console.developers.google.com/apis/api/firestore.googleapis.com/overview?project=insync-class
class _SignUpState extends ConsumerState<SignUp> {
  late ValueNotifier<bool> _currentIndexNotifier;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currentIndexNotifier = ValueNotifier(false);

    super.initState();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    controller.dispose();
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
  }

  // sign user in method
  void signUserUp(bool isTutor) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: Loader(),
          );
        },
      );
      print(emailController.text);
      print(passwordController.text);

      try {
        await ref.read(authControllerProvider).signUp(
              email: emailController.text,
              password: passwordController.text,
              context: context,
              isTutor: isTutor,
            );

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
        print('$e+++++++++++++');
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
        child: ValueListenableBuilder(
            valueListenable: _currentIndexNotifier,
            builder: (context, bool value, child) {
              return Padding(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InContainer(
                                color: value ? kcolorMainPrimary : Colors.white,
                                text: 'Sign up as a Tutor',
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
                                color:
                                    !value ? kcolorMainPrimary : Colors.white,
                                text: 'Sign up as a Student',
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
                                      controller: firstnameController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        hintText: 'first name',
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icons/name.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                      controller: lastnameController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        hintText: 'Last name',
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icons/name.svg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                        Text(
                          !value
                              ? 'Registered with your FUTA Student email address'
                              : "Resgister with your Official Staff email  address",
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
                                // You can remove it and specify it to your taste
                              } else if (!value.contains('futa.edu.ng')
                                  // ||
                                  //     !value.contains('Futa.edu.ng') ||
                                  //     !value.contains('FUTA.edu.ng') ||
                                  //     !value.contains('FUTA.EDU.NG.')

                                  ) {
                                return 'Not a valid FUTA email address';
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
                            controller: passwordController,
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
                            signUserUp(!value ? true : false);
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
              );
            }),
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
