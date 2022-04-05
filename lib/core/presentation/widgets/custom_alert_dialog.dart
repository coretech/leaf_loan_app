import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.text,
    this.buttontext,
    required this.onTap,
    this.status = false,
    this.isImage = false,
  }) : super(key: key);

  final String title;
  final String? text;
  final String? buttontext;
  final Function onTap;
  final bool? status;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            status! ? Icons.check : Icons.cancel_outlined,
            size: 50,
            color: status!
                ? Theme.of(context).primaryColor
                : Theme.of(context).errorColor,
          ),
          const SizedBox(height: 10),
          Text(text!),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onTap as void Function()?,
          child: Text(buttontext ?? 'Okay'.tr()),
        )
      ],
    );
  }
}
