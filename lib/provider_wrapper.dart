import 'package:flutter/material.dart';
import 'package:loan_app/features/articles/ioc/ioc.dart';
import 'package:loan_app/features/articles/presentation/providers/providers.dart';
import 'package:loan_app/features/user_profile/presentation/providers/stats_provider.dart';
import 'package:provider/provider.dart';

class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticlesProvider>.value(
          value: ArticlesIOC.articlesProvider,
        ),
        ChangeNotifierProvider<StatsProvider>(
          create: (_) => StatsProvider()..getStats(),
        ),
      ],
      child: child,
    );
  }
}
