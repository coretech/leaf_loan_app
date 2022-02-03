import 'package:flutter/material.dart';

class DialogCloseWrapper extends StatelessWidget {
  const DialogCloseWrapper({
    Key? key,
    required this.child,
    this.showColumn = true,
  }) : super(key: key);
  final Widget child;
  final bool showColumn;

  @override
  Widget build(BuildContext context) {
    if (showColumn) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: const Text('Close'),
          ),
        ],
      );
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -10,
          top: -10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
