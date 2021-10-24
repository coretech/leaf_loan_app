import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await IntegrationInjector.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      routes: {
        OnboardingScreen.routeName: (ctx) => OnboardingScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
      },
    );
  }
}
