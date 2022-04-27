import 'package:flutter/material.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinConfirmation extends StatefulWidget {
  const PinConfirmation({Key? key}) : super(key: key);

  @override
  _PinConfirmationState createState() => _PinConfirmationState();
}

class _PinConfirmationState extends State<PinConfirmation> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your PIN'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          PinCodeTextField(
            appContext: context,
            animationDuration: const Duration(milliseconds: 300),
            autoFocus: true,
            controller: _otpController,
            keyboardType: TextInputType.number,
            length: 5,
            obscureText: true,
            onChanged: (_) {},
            onCompleted: (v) async {},
            pinTheme: PinTheme(
              activeColor: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(5),
              errorBorderColor: Colors.red,
              fieldHeight: 50,
              fieldOuterPadding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 15,
              ),
              fieldWidth: 40,
              inactiveColor: Theme.of(context).disabledColor,
              selectedColor: Theme.of(context).primaryColorDark,
              shape: PinCodeFieldShape.box,
            ),
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Please enter your Leaf Wallet PIN code to continue'.tr(),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _otpController.text.length == 5
                ? () {
                    Navigator.pop(context, _otpController.text);
                  }
                : null,
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
            child: Text(
              'Confirm'.tr(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

Future<String?> showPinConfirmationSheet(BuildContext context) async {
  // TODO(Yabsra): examine the consequences of the unawaited futures
  // ignore: unawaited_futures
  Smartlook.setRenderingMode(SmartlookRenderingMode.no_rendering);
  final value = await showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => const PinConfirmation(),
  );
  // ignore: unawaited_futures
  Smartlook.setRenderingMode(SmartlookRenderingMode.native);
  return value;
}
