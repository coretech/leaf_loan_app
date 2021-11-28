import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key? key,
    required this.selectedCurrency,
    required this.onTap,
    required this.currency,
    required this.flag,
  }) : super(key: key);

  final String selectedCurrency;
  final ValueChanged<String> onTap;
  final String currency;
  final Flag flag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: Card(
              color: selectedCurrency == currency
                  ? Theme.of(context).primaryColorLight
                  : null,
              elevation: 4,
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  onTap(currency);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      flag,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        currency,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (selectedCurrency == currency)
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
