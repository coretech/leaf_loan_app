import 'package:flutter/material.dart';

class StepIndicator extends StatefulWidget {
  const StepIndicator({
    Key? key,
    required this.total,
    required this.controller,
  }) : super(key: key);
  final int total;
  final PageController controller;

  @override
  _StepIndicatorState createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<StepIndicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
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
        _buildItem(i == widget.controller.page),
      );
    }
    return items;
  }

  Widget _buildItem(bool isActive) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.secondary : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      duration: const Duration(milliseconds: 250),
      height: 10,
      margin: const EdgeInsets.all(2.5),
      width: 10,
    );
  }
}
