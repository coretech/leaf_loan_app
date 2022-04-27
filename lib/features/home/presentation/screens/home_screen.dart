import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/presentation.dart';

import 'package:loan_app/features/home/home.dart';
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
    _homeProvider = HomeIOC.homeProvider()..getActiveLoan();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _homeProvider,
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
        if (!homeProvider.loading) {
          if (homeProvider.activeLoan != null) {
            return ActiveLoanContent(
              homeProvider: homeProvider,
              loadingPayments: homeProvider.loadingPayments,
              loan: homeProvider.activeLoan!,
              payments: homeProvider.payments,
            );
          } else if (homeProvider.errorMessage != null) {
            return Center(
              child: CustomErrorWidget(
                message: homeProvider.errorMessage!,
                onRetry: () => _homeProvider.getActiveLoan(),
              ),
            );
          } else {
            log('message in builder');
            return NoLoanContent(
              onApply: () {},
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
