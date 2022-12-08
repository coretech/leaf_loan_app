import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';

class LoanApplicationFormShimmer extends StatelessWidget {
  const LoanApplicationFormShimmer({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LoanTypeSelection.shimmer(),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LoanCurrencyPicker.shimmer(),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LoanDurationPicker.shimmer(),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LoanAmountPicker.shimmer(context),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LoanPurposePicker(
            onChanged: (_) {},
            purposeList: const [],
            selectedPurpose: null,
          ),
        ),
      ],
    );
  }
}
