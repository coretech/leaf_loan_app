import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();

    return Scaffold(
      appBar: AppBar(
        title: Text('Loan App'),
      ),
    );
  }
}
