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
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LoanTypeProvider, bool>(
      selector: (context, loanProvider) => loanProvider.loading,
      builder: (context, loading, _) {
        return Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ((widget.pageController.page ?? 0) != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : widget.onPrev,
                    child: Text(
                      'Previous'.tr(),
                    ),
                  ),
                ),
              if ((widget.pageController.page ?? 0) != 0)
                const SizedBox(
                  width: 40,
                ),
              Expanded(
                child: ElevatedButton(
                  onPressed: loading ? null : _onNext,
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
    if (widget.pageController.page != 4) {
      return 'Next'.tr();
    } else {
      return 'Submit'.tr();
    }
  }

  void _onNext() {
    if (widget.pageController.page != 4) {
      widget.onNext();
    } else {
      widget.onSubmit();
    }
  }
}
