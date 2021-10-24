import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';


class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTapped,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTapped,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              offset: const Offset(0, 1),
              spreadRadius: 0.5,
            )
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        height: ScreenSize.of(context).height * 0.2,
        width: ScreenSize.of(context).height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 50,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
