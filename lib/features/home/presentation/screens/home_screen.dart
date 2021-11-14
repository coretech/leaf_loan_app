import 'package:flutter/material.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/home/presentation/widgets/no_loan_content.dart';

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
  late bool hasLoan;

  @override
  void initState() {
    super.initState();
    hasLoan = widget.hasLoan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _getContent(),
      ),
    );
  }

  Widget _getContent() {
    if (hasLoan) {
      return ActiveLoanContent(
        onPay: () => setState(() {
          hasLoan = false;
        }),
      );
    } else {
      return NoLoanContent(
        onApply: () => setState(() {
          hasLoan = true;
        }),
      );
    }
  }
}
