import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_app/screens/intro_screen.dart';
import 'package:loan_app/screens/login_screen.dart';
import 'package:loan_app/screens/switch_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    String _user = prefs.getString('username');

    if (_seen && _user == null) {
      Navigator.of(context).pushReplacementNamed(
        SwitchAccountScreen.routeName,
        arguments: true,
      );
    } else if (_seen && _user != null) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/leaf_logo_green.png',
          width: size.width * 0.6,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
