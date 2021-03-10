import 'package:flutter/material.dart';
import 'package:lending_app/screens/main_screen.dart';

void main() {
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
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}
