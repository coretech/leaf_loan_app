import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/presentation.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/home/presentation/providers/home_provider.dart';
import 'package:loan_app/features/home/presentation/widgets/no_loan_content.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.hasLoan,
    required this.hasTransactions,
  }) : super(key: key);
  final bool hasLoan;
  final bool hasTransactions;
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = HomeIOC.homeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _homeProvider..getActiveLoan(),
      builder: (context, _) {
        return Scaffold(
          appBar: const HomeAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: _getContent(),
          ),
        );
      },
    );
  }

  Widget _getContent() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        if (homeProvider.activeLoan != null && !homeProvider.loading) {
          return ActiveLoanContent(
            loadingPayments: homeProvider.loadingPayments,
            loan: homeProvider.activeLoan!,
            payments: homeProvider.payments,
          );
        } else if (homeProvider.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (homeProvider.errorMessage != null) {
          return Center(
            child: CustomErrorWidget(
              message: homeProvider.errorMessage!,
              onRetry: () => _homeProvider.getActiveLoan(),
            ),
          );
        } else {
          return NoLoanContent(
            onApply: () {},
          );
        }
      },
    );
  }
}
