import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:loan_app/provider_wrapper.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthHelper _authHelper = AuthIOC.authHelper();

  @override
  void initState() {
    IntegrationIOC.analytics.logAppOpen();
    IntegrationIOC.recording.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setUpLogOutListener();
  }

  @override
  void dispose() {
    _authHelper.dispose();
    IntegrationIOC.recording.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartlookHelperWidget(
      child: ProviderWrapper(
        child: Consumer<L10nProvider>(
          builder: (context, l10nProvider, _) {
            return MaterialApp(
              navigatorKey: widget.navigatorKey,
              navigatorObservers: [
                if (!Platform.environment.containsKey('FLUTTER_TEST'))
                  FirebaseAnalyticsObserver(
                    analytics: FirebaseAnalytics.instance,
                  ),
              ],
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
                if (settings.name == LoanPaymentScreen.routeName) {
                  final args =
                      settings.arguments as LoanPaymentScreenArguments?;
                  return MaterialPageRoute(
                    builder: (context) => LoanPaymentScreen(
                      loan: args!.loan,
                    ),
                  );
                }
                if (settings.name == LoanDetailScreenAlt.routeName) {
                  final args = settings.arguments as LoanDetailScreenAltArgs?;
                  return MaterialPageRoute(
                    builder: (context) => LoanDetailScreenAlt(
                      loanDetailArgs: args!,
                    ),
                  );
                }
                if (settings.name == LoanTransactionsScreen.routeName) {
                  final args = settings.arguments as LoanData?;
                  return MaterialPageRoute(
                    builder: (context) => LoanTransactionsScreen(
                      loan: args!,
                    ),
                  );
                }
                return null;
              },
              routes: {
                ArticlesScreen.routeName: (context) => const ArticlesScreen(),
                AboutScreen.routeName: (context) => const AboutScreen(),
                ContactUsScreen.routeName: (context) => const ContactUsScreen(),
                LoanApplicationScreen.routeName: (context) =>
                    const LoanApplicationScreen(),
                LoanHistoryScreen.routeName: (context) =>
                    const LoanHistoryScreen(),
                LoginScreen.routeName: (context) => const LoginScreen(),
                OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
                SplashScreen.routeName: (ctx) => const SplashScreen(),
                SettingsScreen.routeName: (ctx) => const SettingsScreen(),
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
              title: 'Leaf Loans',

              darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.green,
                colorScheme: ColorScheme.dark(
                  primary: Colors.green,
                  secondary: Colors.orange.withGreen(210).withBlue(55),
                ),
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported

                for (final supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first
                // one from the list (English, in this case).
                return supportedLocales.first;
              },
              supportedLocales: AppLocalizations.supportedLocales,
              locale: l10nProvider.locale,
            );
          },
        ),
      ),
    );
  }

  void _setUpLogOutListener() {
    _authHelper.authenticationStream.listen((loggedOut) {
      if (loggedOut) {
        widget.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          SplashScreen.routeName,
          (_) => false,
        );
      }
    });
  }
}
