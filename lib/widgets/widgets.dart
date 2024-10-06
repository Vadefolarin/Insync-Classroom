import 'package:flutter/material.dart';

import '../views/onboarding/continue_as.dart';
import '../utils/app_shadow.dart';
import '../utils/text_widgets.dart';

Widget appOnboardingPage(BuildContext context, PageController controller,
    {String imagePath = "assets/images/reading.png",
    String title = "",
    String subtitle = "",
    index = 0}) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
      Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: Text24Normal(text: title),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Text16Normal(text: subtitle),
      ),
      _nextButton(index, controller, context),
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      } else {
        // Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY, true);
        // Navigator.pushNamed(context, "/sign_in");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ContinueAsWidget()));
      }
    },
    child: Container(
      margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
      width: 325,
      height: 50,
      decoration: appBoxShadow(),
      child: Center(
        child: Text16Normal(
            text: index < 3 ? "Next" : "Get Started", color: Colors.white),
      ),
    ),
  );
}
