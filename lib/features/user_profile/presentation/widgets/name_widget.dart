import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'John Doe',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.verified_outlined,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
        Text(
          '(johndoe)',
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
