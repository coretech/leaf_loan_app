import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class StepIndicator extends StatefulWidget {
  const StepIndicator({
    Key? key,
    required this.total,
    required this.pageController,
  }) : super(key: key);
  final int total;
  final PageController pageController;

  @override
  _StepIndicatorState createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<StepIndicator> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_pageControllerListener);
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                TextSpan(
                  text: '${'Step'.tr()} ',
                ),
                TextSpan(
                  text: '${currentPage + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' ${'of'.tr()} ',
                ),
                TextSpan(
                  text: '${widget.total}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pageControllerListener() {
    final controller = widget.pageController;
    if (controller.page != null && controller.page!.round() != currentPage) {
      setState(() {
        currentPage = controller.page!.round();
      });
    }
  }
}
