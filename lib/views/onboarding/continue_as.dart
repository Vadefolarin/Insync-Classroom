import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../widgets/button_widgets.dart';
import '../authentication/login/login.dart';

bool isTutor = false;

class ContinueAsWidget extends StatefulWidget {
  const ContinueAsWidget({super.key});

  @override
  _ContinueAsWidgetState createState() => _ContinueAsWidgetState();
}

class _ContinueAsWidgetState extends State<ContinueAsWidget> {
  String _selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              const Text(
                'Continue as',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appButton(
                    func: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isTutor', true);
                      setState(() {
                        _selectedRole = 'Teacher';
                        isTutor = true;
                      });
                    },
                    color:
                        _selectedRole == 'Teacher' ? Colors.white : Colors.grey,
                    text: 'Teacher',
                  ),
                  const SizedBox(height: 20.0),
                  appButton(
                    func: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isTutor', false);

                      setState(() {
                        _selectedRole = 'Student';
                        isTutor = false;
                      });
                    },
                    color:
                        _selectedRole == 'Student' ? Colors.white : Colors.grey,
                    text: 'Student',
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Selected Role: $_selectedRole',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              AppButton(
                width: 200,
                onTap: () {
                  if (_selectedRole.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                    // Navigator.pushNamed(context, 'login');
                  }
                },
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.green,
                text: 'Continue',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
