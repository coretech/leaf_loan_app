import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class PayButton {
  static Widget labeled({
    required BuildContext context,
    required String label,
    bool mini = false,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          mini ? const Size.fromHeight(40) : const Size(150, 50),
        ),
      ),
      child: Text(
        label,
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
      icon: Icons.price_check_outlined,
      label: label,
      onTapped: onTap,
    );
  }
}
