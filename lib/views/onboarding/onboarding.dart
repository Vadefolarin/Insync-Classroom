import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/image_res.dart';
import '../../widgets/widgets.dart';


// final indexProvider = StateProvider<int>((ref) => 0);

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> {
  final PageController _pageController = PageController();
  late ValueNotifier<int> _currentPage;

  int dotsIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPage = ValueNotifier(0);
  }

  @override
  void dispose() {
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, currentPage, __) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: PageView(
                    onPageChanged: (value) {
                      _currentPage.value = value;

                      // ref.read(indexDotProvider.notifier).changeIndex(value);
                    },
                    controller: _pageController,
                    children: [
                      //first page
                      appOnboardingPage(context, _pageController,
                          imagePath: ImageRes.imgWelcome1,
                          title: "First See Learning",
                          subtitle:
                              "Forget about the paper, now Learning all in one place",
                          index: 1),
                      //second page
                      appOnboardingPage(context, _pageController,
                          imagePath: ImageRes.imgWelcome2,
                          title: "Connect With Everyone",
                          subtitle:
                              "Always keep in touch with your tutor and friends. Lets get connected",
                          index: 2),
                      //third page
                      appOnboardingPage(context, _pageController,
                          imagePath: ImageRes.imgWelcome3,
                          title: "Always Fascinated Learning",
                          subtitle:
                              "Anywhere, Anytime. the time is at your discretion. So study wherever u can.",
                          index: 3),
                    ],
                  ),
                ),
                DotsIndicator(
                  position: currentPage,
                  dotsCount: 3,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(24.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
