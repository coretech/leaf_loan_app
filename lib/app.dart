import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/authentication/authentication.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        LoanHistoryScreen.routeName: (context) => const LoanHistoryScreen(),
        MainScreen.routeName: (context) => const NewHomeScreen(),
        OnboardingScreen.routeName: (ctx) => OnboardingScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.light(
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
      themeMode: ThemeMode.light,
    );
  }
}
