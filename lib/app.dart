import 'package:flutter/material.dart';
import 'package:loan_app/features/features.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final AuthHelper _authHelper = AuthHelper();

  @override
  void initState() {
    super.initState();
    _setUpLogOutListener();
  }

  @override
  void dispose() {
    _authHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _navigatorKey,
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
        AboutScreen.routeName: (context) => const AboutScreen(),
        LoanHistoryScreen.routeName: (context) => const LoanHistoryScreen(),
        LoanPaymentScreen.routeName: (context) => const LoanPaymentScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
        SplashScreen.routeName: (ctx) => const SplashScreen(),
        UserProfileScreen.routeName: (ctx) => const UserProfileScreen(),
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

  void _setUpLogOutListener() {
    _authHelper.authenticationStream.listen((loggedOut) {
      _navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/',
        (_) => false,
      );
    });
  }
}
