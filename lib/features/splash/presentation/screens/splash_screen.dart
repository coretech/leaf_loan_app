import 'package:flutter/material.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';
import 'package:loan_app/features/splash/presentation/providers/providers.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late OnboardingStatusRepo onboardingStatusRepo;
  late ScoringDataCollectionService scoringDataCollectionService;
  late SplashProvider _splashProvider;
  @override
  void initState() {
    onboardingStatusRepo = OnboardingStatusHiveRepo();
    scoringDataCollectionService = CredoDataCollectionService();
    _splashProvider = SplashProvider()..initializeApp();
    _splashProvider
      ..addListener(_navigateNext)
      ..initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SplashProvider>(
      create: (_) => _splashProvider,
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

  void _navigateNext() {
    if (!_splashProvider.onboardingSeen && !_splashProvider.loading) {
      Navigator.of(context).pushReplacementNamed(
        OnboardingScreen.routeName,
      );
    }
    if (!_splashProvider.authenticated && !_splashProvider.loading) {
      Navigator.of(context).pushReplacementNamed(
        LoginScreen.routeName,
      );
    }
    if (_splashProvider.authenticated) {
      Navigator.of(context).pushReplacementNamed(
        HomeScreen.routeName,
      );
    }
  }
}
