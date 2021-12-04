import 'package:flutter/material.dart';

class ActiveLoanAction extends StatelessWidget {
  const ActiveLoanAction({
    Key? key,
    required this.description,
    this.onTap,
    required this.title,
  }) : super(key: key);

  final String description;
  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
