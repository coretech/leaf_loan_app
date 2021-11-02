import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/authentication/authentication.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late OnboardingStatusRepo onboardingStatusRepo;
  late ScoringDataCollectionService scoringDataCollectionService;
  late SplashCubit splashCubit;
  @override
  void initState() {
    onboardingStatusRepo = OnboardingStatusHiveRepo();
    scoringDataCollectionService = CredoDataCollectionService();
    splashCubit = SplashCubit(
      onboardingStatusRepo: onboardingStatusRepo,
      scoringDataCollectionService: scoringDataCollectionService,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: splashCubit..initializeApp(),
      listener: (context, state) {
        if (state.onboardingSeen) {
          Navigator.of(context).pushReplacementNamed(
            LoginScreen.routeName,
          );
        } else {
          Navigator.of(context).pushReplacementNamed(
            OnboardingScreen.routeName,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/leaf_logo_green.png',
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
