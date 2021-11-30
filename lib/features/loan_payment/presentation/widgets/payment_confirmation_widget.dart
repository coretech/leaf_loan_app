import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class PaymentConfirmationWidget extends StatelessWidget {
  const PaymentConfirmationWidget({
    Key? key,
    required this.amount,
    required this.remainingAmount,
    required this.dueDate,
  }) : super(key: key);
  final String amount;
  final String remainingAmount;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Payment Info',
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16),
              ),
              Text(
                '$amount KES',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining Loan Amount',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16),
              ),
              Text(
                '$remainingAmount KES',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You will have to pay enter your pin code to confirm this payment',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              showPinConfirmationSheet(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.disabled)
                    ? null
                    : Theme.of(context).colorScheme.secondary,
              ),
              fixedSize: MaterialStateProperty.all(
                Size(
                  ScreenSize.of(context).width - 40,
                  50,
                ),
              ),
            ),
            child: const Text(
              'Proceed',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool?> showPaymentConfirmationSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const PaymentConfirmationWidget(
      amount: '1000',
      remainingAmount: '1124',
      dueDate: 'Jan 1, 2022',
    ),
  );
  return false;
}
