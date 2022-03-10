import 'package:flutter/material.dart';
import 'package:loan_app/features/home/presentation/widgets/widgets.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';

class BigPersistentApplyButton extends StatelessWidget {
  const BigPersistentApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: BigPersistentApplyButtonDelegate(),
      pinned: true,
    );
  }
}

class BigPersistentApplyButtonDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 95;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoanApplicationScreen(),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primary,
          ),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          fixedSize: MaterialStateProperty.all(const Size(150, 70)),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Apply for a loan now'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const MaxLoanAmountText(),
            ],
          ),
        ),
      ),
    );
  }
}
