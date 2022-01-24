import 'package:flutter/material.dart';

class OnboardingStepIndicator extends StatefulWidget {
  const OnboardingStepIndicator({
    Key? key,
    required this.total,
    required this.controller,
  }) : super(key: key);
  final int total;
  final PageController controller;

  @override
  _OnboardingStepIndicatorState createState() =>
      _OnboardingStepIndicatorState();
}

class _OnboardingStepIndicatorState extends State<OnboardingStepIndicator> {
  bool initial = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        initial = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final items = <Widget>[];
    for (var i = 0; i < widget.total; i++) {
      items.add(
        _buildItem(_shouldBeActive(i)),
      );
    }
    return items;
  }

  bool _shouldBeActive(int index) {
    if (initial) {
      return index == 0;
    }
    return index == widget.controller.page;
  }

  Widget _buildItem(bool isActive) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.secondary : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 7.5,
      margin: const EdgeInsets.all(2.5),
      width: 7.5,
    );
  }
}
