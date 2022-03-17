import 'package:flutter/material.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingProvider _onboardingProvider;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
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
        title: 'Easy Application'.tr(),
        description: 'Apply for a loan with almost instant approval'.tr(),
        image: 'assets/images/application.png',
      ),
      _buildSlide(
        context,
        title: 'Easy Payment'.tr(),
        description: 'Pay off your loan from your Leaf Wallet'.tr(),
        image: 'assets/images/smartphone_payment.png',
      ),
      _buildSlide(
        context,
        title: 'Score and Insights'.tr(),
        description: 'Build your credit score and see personalized '
                'insights on your profile'
            .tr(),
        image: 'assets/images/growth.png',
      ),
      _buildSlide(
        context,
        title: 'Learn with Leaf'.tr(),
        description: 'Learn about how taking and paying small'
                ' loans can change your life'
            .tr(),
        image: 'assets/images/financial_knowledge.png',
      ),
    ];

    return Provider(
      create: (context) => _onboardingProvider,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              toolbarHeight: 100,
              title: Row(
                children: const [
                  LeafLoansLogo(),
                  Spacer(),
                  LanguageDropdown(location: 'onboarding'),
                ],
              ),
            ),
            body: PageView(
              controller: _pageController,
              children: _slides,
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!_pageController.hasClients ||
                        _pageController.page?.round() != _slides.length - 1)
                      Expanded(
                        child: TextButton(
                          key: const Key('next_button'),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text('Next'.tr()),
                        ),
                      )
                    else
                      const Spacer(),
                    OnboardingStepIndicator(
                      total: _slides.length,
                      controller: _pageController,
                    ),
                    if (_pageController.hasClients &&
                        _pageController.page?.round() == _slides.length - 1)
                      Expanded(
                        child: TextButton(
                          onPressed: _updateOnboardingStatus,
                          child: Text('Done'.tr()),
                        ),
                      )
                    else
                      Expanded(
                        child: TextButton(
                          key: const Key('skip_button'),
                          onPressed: _updateOnboardingStatus,
                          child: Text(
                            'Skip'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlide(
    BuildContext context, {
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
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
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Future<void> _updateOnboardingStatus() async {
    await _onboardingProvider.updateOnboardingStatus();
  }
}
