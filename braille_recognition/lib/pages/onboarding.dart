import 'package:braille_recognition/fragments/onboarding_fragment.dart';
import 'package:braille_recognition/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  double percent = 0.25;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            percent = 0.25 * (value+1);
          });
        },
        children: [
          OnboardingFragment(
            title: "Helps to comunicate",
            description:
                "Translate Braille into one of the many languages available, and vice versa. Import images for translation directly from the device memory or take a photo",
            illustration: "images/meeting.png",
            illustrationBg: "images/onboarding_0.png",
          ),
          OnboardingFragment(
            title: "Convenient to use",
            description:
                "Import images for translation directly from the device memory or take a photo. Translate Braille into one of the many languages available, and vice versa.",
            illustration: "images/global.png",
            illustrationBg: "images/onboarding_1.png",
          ),
          OnboardingFragment(
            title: "Get started",
            description: "Start using for free now!",
            illustration: "images/getstart.png",
            illustrationBg: "images/onboarding_2.png",
          ),
        ],
      ),
      floatingActionButton: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircularPercentIndicator(
              radius: 39,
              animation: true,
              animateFromLastPercent: true,
              percent: percent,
              linearGradient: const LinearGradient(colors: [
                Color(0xFFB3EAFF),
                Color(0xFF4AB7E0),
                Color(0xFF0AB0EF),
              ]),
              lineWidth: 3,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            CircleButton(
              size: 60,
              onTap: () {
                pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.ease);
              },
            )
          ],
        ),
      ),
    );
  }
}