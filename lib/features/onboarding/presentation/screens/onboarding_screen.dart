import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingProvider _onboardingProvider;

  @override
  void initState() {
    _onboardingProvider = OnboardingProvider();
    _onboardingProvider.addListener(() {
      if (_onboardingProvider.seen && _onboardingProvider.seen) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _slides = [
      _buildSlide(
        context,
        title: 'Easy Application',
        description: 'Apply for a loan with almost instant approval',
        image: 'assets/images/application.png',
      ),
      _buildSlide(
        context,
        title: 'Easy Payment',
        description: 'Pay off your loan from your Leaf Wallet',
        image: 'assets/images/smartphone_payment.png',
      ),
      _buildSlide(
        context,
        title: 'Score and Insights',
        description: 'Build your credit score and see personalized '
            'insights on your profile',
        image: 'assets/images/growth.png',
      ),
      _buildSlide(
        context,
        title: 'Learn with Leaf',
        description: 'Learn about how taking and paying small'
            ' loans can change your life',
        image: 'assets/images/financial_knowledge.png',
      ),
    ];

    return Provider(
      create: (context) => _onboardingProvider,
      child: Builder(
        builder: (context) {
          return IntroSlider(
            backgroundColorAllSlides: Theme.of(context).scaffoldBackgroundColor,
            colorActiveDot: Theme.of(context).primaryColor,
            doneButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            nextButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            onDonePress: _updateOnboardingStatus,
            onSkipPress: _updateOnboardingStatus,
            showNextBtn: true,
            showDoneBtn: true,
            skipButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            slides: _slides,
          );
        },
      ),
    );
  }

  Slide _buildSlide(
    BuildContext context, {
    required String title,
    required String description,
    required String image,
  }) {
    return Slide(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerWidget: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 25,
              ),
              child: Image.asset(
                image,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateOnboardingStatus() async {
    await _onboardingProvider.updateOnboardingStatus();
  }
}
