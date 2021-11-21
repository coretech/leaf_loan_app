import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Text(
            'Contact Info',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Address',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Kigali, Rwanda',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Phone Number',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '+250 780 000 005',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
