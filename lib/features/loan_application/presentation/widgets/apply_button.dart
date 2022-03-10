import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/i18n/i18n.dart';

class ApplyButton {
  static Widget labeled({
    required BuildContext context,
    required String label,
    bool mini = false,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          mini ? const Size(135, 30) : const Size(200, 50),
        ),
      ),
      child: Text(
        'Apply now'.tr(),
        style: TextStyle(
          fontSize: mini ? 13 : 20,
        ),
      ),
    );
  }

  static Widget withIcon({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    return ActionButton(
      icon: Icons.request_quote_outlined,
      label: label,
      onTapped: onTap,
    );
  }

  static Widget circular({
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                color: Theme.of(context).canvasColor,
                spreadRadius: 0.5,
              )
            ],
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(20),
          height: ScreenSize.of(context).height * 0.3,
          width: ScreenSize.of(context).height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/leaf_white.png',
                height: ScreenSize.of(context).height * 0.125,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 5),
              Text(
                'Apply'.tr(),
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
