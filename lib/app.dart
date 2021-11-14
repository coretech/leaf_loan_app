import 'package:flutter/material.dart';
import 'package:loan_app/features/articles/articles.dart';
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
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          final args = settings.arguments as HomeScreenArguments?;
          return MaterialPageRoute(
            builder: (context) => HomeScreen(
              hasTransactions: args?.hasTransactions ?? false,
              hasLoan: args?.hasLoan ?? false,
            ),
          );
        }
      },
      routes: {
        ArticlesScreen.routeName: (context) => const ArticlesScreen(),
        LoanHistoryScreen.routeName: (context) => const LoanHistoryScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
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
