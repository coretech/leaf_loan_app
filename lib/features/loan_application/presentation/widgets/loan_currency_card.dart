import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class LoanCurrencyCard extends StatelessWidget {
  const LoanCurrencyCard({
    Key? key,
    required this.currency,
    required this.flag,
    required this.index,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  final LoanCurrency currency;
  final Flag flag;
  final int index;
  final ValueChanged<int> onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: Card(
              color: selectedIndex == index
                  ? Theme.of(context).primaryColorLight
                  : null,
              elevation: 4,
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  onTap(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      flag,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        currency.fiatCode,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (selectedIndex == index)
            Positioned(
              top: 5,
              right: 5,
              child: Center(
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
