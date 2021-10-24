import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingCubit _onboardingCubit;
  late OnboardingStatusRepo _onboardingStatusRepo;

  @override
  void initState() {
    _onboardingStatusRepo = OnboardingStatusHiveRepo();
    _onboardingCubit =
        OnboardingCubit(onboardingStatusRepo: _onboardingStatusRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Slide> _slides = [
      _buildSlide(
        context,
        title: 'Store Money',
        description:
            'Keep your money safe by storing it digitally with Leaf—for however long you need. Say goodbye to the risks of cash!',
        image: 'assets/images/safe.png',
      ),
      _buildSlide(
        context,
        title: 'Send Money',
        description:
            'Send and receive money instantly with your friends and family for free.',
        image: 'assets/images/transfer.png',
      ),
      _buildSlide(
        context,
        title: 'Exchange Money',
        description:
            'Hold and transact in any currency Leaf supports with great rates and instant exchange.',
        image: 'assets/images/exchange.png',
      ),
      _buildSlide(
        context,
        title: 'Pay with Leaf',
        description:
            'Grow your business by using Leaf locally and across borders. Customers, merchants, and suppliers can save time and money by paying with Leaf.',
        image: 'assets/images/pay.png',
      ),
      _buildSlide(
        context,
        title: 'International Coverage',
        description:
            'Tired of expensive international transfers? Send and receive money across borders, instantly and for free.',
        image: 'assets/images/international.png',
      ),
    ];

    return BlocListener<OnboardingCubit, OnboardingState>(
      bloc: _onboardingCubit,
      listener: (context, state) {
        if (state is OnboardingStateChecked && state.seen) {
          Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        }
      },
      child: IntroSlider(
        backgroundColorAllSlides: Colors.white,
        slides: _slides,
        colorActiveDot: Theme.of(context).primaryColor,
        showNextBtn: true,
        showDoneBtn: true,
        nextButtonStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        doneButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        onDonePress: () {
          _onboardingCubit.updateOnboardingStatus(seen: true);
        },
        skipButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        onSkipPress: () {
          _onboardingCubit.updateOnboardingStatus(seen: true);
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
      title: title,
      styleTitle: TextStyle(
        fontFamily: 'Franklin',
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor,
        fontSize: 25,
      ),
      description: description,
      styleDescription: TextStyle(color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}
