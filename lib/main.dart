import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/app.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/features_ioc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IntegrationIOC.init();
  await FeaturesIOC.init();
  await Firebase.initializeApp();

  runApp(App());
}
