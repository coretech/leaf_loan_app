import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/old/screens/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    String? _user = prefs.getString('username');

    if (_seen && _user == null) {
      Navigator.of(context).pushReplacementNamed(
        LoginScreen.routeName,
        arguments: true,
      );
    } else if (_seen && _user != null) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      await prefs.setBool('seen', true);
      //TODO: replace this with intro
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  Future<void> _triggerCredoSdk() async {
    const platform = const MethodChannel('com.leafglobal.loanapp/credolabs');

    await [
      Permission.location,
      Permission.contacts,
      Permission.calendar,
      Permission.storage,
      Permission.mediaLibrary,
    ].request();

    try {
      final referenceNumber = Random().nextInt(1000);
      await platform.invokeMethod(
        'submitCredoLabsData',
        {
          'authKey': 'authKey',
          'referenceNumber': referenceNumber.toString(),
          'url': 'credoUrl',
        },
      ).then((result) {
        print('damn');
        print(result.toString());
      });
    } on PlatformException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

      await _triggerCredoSdk();

      // checkFirstSeen();
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
