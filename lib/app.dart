import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/authentication/authentication.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';
import 'package:loan_app/features/splash/splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        LoanHistoryScreen.routeName: (context) => const LoanHistoryScreen(),
        MainScreen.routeName: (context) => const NewHomeScreen(),
        OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
        SplashScreen.routeName: (ctx) => const SplashScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.orange,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.dark(
          primary: Colors.green,
          secondary: Colors.orange.withGreen(210).withBlue(55),
        ),
      ),
    );
  }
}
