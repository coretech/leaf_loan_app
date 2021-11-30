import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_payment/presentation/widgets/widgets.dart';

class LoanPaymentScreen extends StatefulWidget {
  const LoanPaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/loan-payment';

  @override
  _LoanPaymentScreenState createState() => _LoanPaymentScreenState();
}

class _LoanPaymentScreenState extends State<LoanPaymentScreen> {
  late TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text('Pay for your Asset Loan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(),
            Text(
              'Your current remaining loan amount is ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'KSH ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: '12,960',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 50,
              height: 30,
              indent: 50,
            ),
            Text(
              'Your KSH balance on Leaf Wallet is ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'KSH ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: '5,000',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorMaxLines: 3,
                labelText: 'Enter the amount you want to pay',
                prefixText: 'KSH ',
                prefixStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              keyboardType: TextInputType.number,
              validator: _validateAmount,
            ),
            if (_validateAmount(_amountController.text) == null)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  'You will have '
                  '${_getRemaining()}'
                  ' KSH remaining to pay after paying this amount',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text(
                'Pay',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: _validateAmount(_amountController.text) == null
                  ? () async {
                      await showPaymentConfirmationSheet(context);
                      // ignore: use_build_context_synchronously
                      await Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    }
                  : null,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(
                    ScreenSize.of(context).width - 40,
                    50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateAmount(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter the amount you want to pay';
    }
    if (double.tryParse(value!) == null) {
      return 'Please enter a valid amount';
    }
    if (double.parse(value) > 12960) {
      return 'Please enter an amount that is less than or equal '
          'to your remaining amount';
    }
    if (double.parse(value) > 5000) {
      return 'Please enter an amount that is less than or equal '
          'to your Leaf Wallet balance';
    }
  }

  String _getRemaining() {
    return (12960 - double.parse(_amountController.text)).toStringAsFixed(2);
  }
}
