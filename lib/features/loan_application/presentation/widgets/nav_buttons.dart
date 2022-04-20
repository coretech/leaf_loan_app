import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class NavButtons extends StatefulWidget {
  const NavButtons({
    Key? key,
    required this.pageController,
    required this.onSubmit,
    required this.onNext,
    required this.onPrev,
  }) : super(key: key);

  final PageController pageController;
  final VoidCallback onSubmit;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  State<NavButtons> createState() => _NavButtonsState();
}

class _NavButtonsState extends State<NavButtons> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_pageControllerListener);
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanTypeProvider>(
      builder: (context, loanTypeProvider, _) {
        final enabled = loanTypeProvider.canShowTypes;
        return Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: enabled ? widget.onPrev : null,
                    child: Text(
                      'Previous'.tr(),
                    ),
                  ),
                ),
              if (currentPage != 0)
                const SizedBox(
                  width: 40,
                ),
              Expanded(
                child: ElevatedButton(
                  onPressed: enabled ? _onNext : null,
                  child: Text(
                    _getText(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getText() {
    if (currentPage != 4) {
      return 'Next'.tr();
    } else {
      return 'Submit'.tr();
    }
  }

  void _onNext() {
    if (currentPage != 4) {
      widget.onNext();
    } else {
      widget.onSubmit();
    }
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
