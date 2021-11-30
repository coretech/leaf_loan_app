import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({
    Key? key,
    required this.amount,
    required this.amountDue,
    required this.interestRate,
    required this.purpose,
    required this.typeName,
    required this.dueDate,
  }) : super(key: key);
  final String amount;
  final String amountDue;
  final String interestRate;
  final String purpose;
  final String typeName;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Loan Info',
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Loan Type',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  typeName,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Amount',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  amount,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Interest Rate',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  interestRate,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Amount Due',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  amountDue,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Due Date',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  dueDate,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Loan Purpose',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  purpose,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You will have to pay enter your pin code to confirm this loan',
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
