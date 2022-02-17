import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({
    Key? key,
    required this.children,
    required this.color,
  }) : super(key: key);
  final List<Widget> children;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Stack(
        children: [
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.black.withOpacity(0.25),
                  color,
                ],
              ),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                ...children,
                const SizedBox(
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
