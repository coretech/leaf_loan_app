import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/providers/auth.dart';
import 'package:loan_app/screens/login_screen.dart';
import 'package:loan_app/screens/main_screen.dart';
import 'package:loan_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        SplashScreen.routeName: (ctx) => SplashScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}
