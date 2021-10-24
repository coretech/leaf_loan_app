import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/app.dart';
import 'package:loan_app/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IntegrationInjector.init();
  await Firebase.initializeApp();

  runApp(App());
}
