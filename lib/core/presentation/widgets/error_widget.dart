import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:loan_app/i18n/i18n.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Transform.rotate(
          angle: math.pi / 2,
          child: Text(
            ':(',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        if (onRetry != null)
          ElevatedButton(
            onPressed: onRetry,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              fixedSize: MaterialStateProperty.all(
                const Size.fromHeight(40),
              ),
            ),
            child: Text(
              'Retry'.tr(),
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }
}
