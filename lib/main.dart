import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:loan_app/providers/auth.dart';

import 'package:loan_app/screens/intro_screen.dart';
import 'package:loan_app/screens/login_screen.dart';
import 'package:loan_app/screens/main_screen.dart';
import 'package:loan_app/screens/splash_screen.dart';
import 'package:loan_app/screens/switch_account_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthLogic()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        routes: {
          SplashScreen.routeName: (ctx) => SplashScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SwitchAccountScreen.routeName: (ctx) => SwitchAccountScreen(),
          IntroScreen.routeName: (ctx) => IntroScreen(),
        },
      ),
    );
  }
}
