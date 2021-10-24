import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        OnboardingScreen.routeName: (ctx) => OnboardingScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          accentColor: Colors.orangeAccent,
        ),
      ),
    );
  }
}
