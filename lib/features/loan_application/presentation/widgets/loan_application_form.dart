import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/domain.dart';
import 'package:loan_app/core/presentation/presentation.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanApplicationForm extends StatefulWidget {
  const LoanApplicationForm({
    Key? key,
    required this.level,
    required this.provider,
  }) : super(key: key);
  final LoanLevel level;
  final LoanTypesProvider provider;

  @override
  State<LoanApplicationForm> createState() => _LoanApplicationFormState();
}

class _LoanApplicationFormState extends State<LoanApplicationForm> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  int _selectedCurrencyIndex = 0;
  int _selectedLoanTypeIndex = 0;
  int _selectedDurationInDays = 60;
  double? _loanAmount;
  String? _selectedPurpose;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageControllerListener);
    widget.provider.addListener(_loanApplicationListener);
  }

  @override
  void didChangeDependencies() {
    widget.provider.fetch();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LoanTypesProvider, LoanTypesState>(
      selector: (_, provider) => provider.state,
      builder: (context, state, _) {
        if (state is LoanTypesError) {
          return Center(
            child: CustomErrorWidget(
              message: state.message,
              onRetry: widget.provider.fetch,
            ),
          );
        }

        if (state is LoanTypesLoaded) {
          LoanType? selectedLoanType;
          final hasLoanTypes = state.loanTypes.isNotEmpty;

          if (hasLoanTypes) {
            selectedLoanType = state.loanTypes[_selectedLoanTypeIndex];
          }
          final hasCurrencies = selectedLoanType?.hasCurrencies ?? false;
          final hasLoanTypesAndCurrencies = hasCurrencies && hasLoanTypes;
          LoanCurrency? selectedCurrency;
          if (hasLoanTypesAndCurrencies) {
            selectedCurrency =
                selectedLoanType!.currencies[_selectedCurrencyIndex];
          }

          return _buildLoadedView(
            state: state,
            hasLoanTypes: hasLoanTypes,
            selectedLoanType: selectedLoanType,
            hasLoanTypesAndCurrencies: hasLoanTypesAndCurrencies,
            selectedCurrency: selectedCurrency,
          );
        }

        return LoanApplicationFormShimmer(
          controller: _pageController,
        );
      },
    );
  }

  Widget _buildLoadedView({
    required LoanTypesLoaded state,
    required bool hasLoanTypes,
    required LoanType? selectedLoanType,
    required bool hasLoanTypesAndCurrencies,
    required LoanCurrency? selectedCurrency,
  }) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoanTypeSelection(
                  loanTypes: state.loanTypes,
                  loanLevel: widget.level,
                  onSelection: (selectedIndex) => _onLoanTypeSelected(
                    selectedIndex,
                    state.loanTypes,
                  ),
                  selectedIndex: _selectedLoanTypeIndex,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoanCurrencyPicker(
                  currencies: hasLoanTypes ? selectedLoanType!.currencies : [],
                  onChanged: (selectedIndex) => _onCurrencySelected(
                    selectedIndex,
                    state.loanTypes,
                  ),
                  selectedIndex: _selectedCurrencyIndex,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoanDurationPicker(
                  durationInDays: _selectedDurationInDays,
                  maxDurationInDays:
                      hasLoanTypes ? selectedLoanType!.maxDuration : null,
                  minDurationInDays:
                      hasLoanTypes ? selectedLoanType!.minDuration : null,
                  onChanged: _onDurationInDaysSelected,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoanAmountPicker(
                  fiatCode: hasLoanTypesAndCurrencies
                      ? selectedCurrency!.fiatCode
                      : null,
                  interestRate:
                      hasLoanTypes ? selectedLoanType!.interestRate : null,
                  loanAmount: _loanAmount ??
                      (hasLoanTypesAndCurrencies
                          ? selectedCurrency!.maxLoanAmount
                          : 0),
                  maxAmount: hasLoanTypesAndCurrencies
                      ? selectedCurrency!.maxLoanAmount
                      : null,
                  minAmount: hasLoanTypesAndCurrencies
                      ? selectedCurrency!.minLoanAmount
                      : null,
                  onChanged: _onLoanAmountChanged,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LoanPurposePicker(
                  onChanged: _onPurposeSelected,
                  purposeList: hasLoanTypes ? selectedLoanType!.purpose : [],
                  selectedPurpose: _selectedPurpose,
                ),
              ),
            ],
          ),
        ),
        StepIndicator(
          total: 5,
          pageController: _pageController,
        ),
        NavButtons(
          pageController: _pageController,
          onSubmit: () => _onSubmitPressed(state.loanTypes),
          onNext: () => _onNext(state.loanTypes),
          onPrev: _onPrev,
        )
      ],
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool _canGoNext(List<LoanType> loanTypes) {
    final currentVal = _pageController.page;
    return (_amountIsValid(_loanAmount, loanTypes) || currentVal != 3) &&
        (_hasValidCurrencies(loanTypes) || currentVal != 1);
  }

  void _onNext(List<LoanType> loanTypes) {
    if (_canGoNext(loanTypes)) {
      setState(() {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      });
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (!_amountIsValid(_loanAmount, loanTypes) && currentPage == 3) {
      showSnackbar('Loan amount is invalid!'.tr());
    } else if (!_hasValidCurrencies(loanTypes)) {
      showSnackbar('You need at least one currency to proceed'.tr());
    }
  }

  void _onPrev() {
    setState(() {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _onSubmitPressed(List<LoanType> loanTypes) {
    if (_canSubmit(loanTypes)) {
      _onSubmit(loanTypes);
    } else {
      if (!_hasValidCurrencies(loanTypes)) {
        showSnackbar('You need at least one currency to proceed'.tr());
      } else if (_loanAmount == null) {
        showSnackbar('Please select loan amount!'.tr());
      } else if (_selectedPurpose == null) {
        showSnackbar('Please select loan purpose!'.tr());
      } else if (_selectedDurationInDays < 60) {
        showSnackbar('Please select a proper loan duration!'.tr());
      }
    }
  }

  bool _canSubmit(List<LoanType> loanTypes) {
    return _amountIsValid(_loanAmount, loanTypes) && _selectedPurpose != null;
  }

  bool _amountIsValid(double? amount, List<LoanType> loanTypes) {
    final currentLoan = loanTypes[_selectedLoanTypeIndex];
    if (currentLoan.hasCurrencies) {
      final selectedCurrency = currentLoan.currencies[_selectedCurrencyIndex];
      return amount != null &&
          amount <= selectedCurrency.maxLoanAmount &&
          amount >= selectedCurrency.minLoanAmount;
    }
    return false;
  }

  bool _hasValidCurrencies(List<LoanType> loanTypes) {
    final currentLoan = loanTypes[_selectedLoanTypeIndex];
    return currentLoan.hasCurrencies;
  }

  void _pageControllerListener() {
    final controller = _pageController;
    if (controller.page != null && controller.page!.round() != currentPage) {
      setState(() {
        currentPage = controller.page!.round();
      });
    }
  }

  void _onPurposeSelected(String purpose) {
    setState(() {
      _selectedPurpose = purpose;
    });
  }

  void _onLoanAmountChanged(double? loanAmount) {
    setState(() {
      _loanAmount = loanAmount;
    });
  }

  void _onLoanTypeSelected(int value, List<LoanType> loanTypes) {
    final selectedLoan = loanTypes[value];
    setState(() {
      _selectedLoanTypeIndex = value;
      if (selectedLoan.hasCurrencies) {
        _selectedCurrencyIndex = 0;
        _loanAmount =
            selectedLoan.currencies[_selectedCurrencyIndex].minLoanAmount;
      }
    });
  }

  void _onCurrencySelected(int value, List<LoanType> loanTypes) {
    setState(() {
      _selectedCurrencyIndex = value;
      _loanAmount = loanTypes[_selectedLoanTypeIndex]
          .currencies[_selectedCurrencyIndex]
          .minLoanAmount;
    });
  }

  void _onDurationInDaysSelected(int durationInDays) {
    setState(() {
      _selectedDurationInDays = durationInDays;
    });
  }

  void showAmountErrorSnackbar() {
    showSnackbar('Please select a proper loan amount'.tr());
  }

  Future<void> _onSubmit(List<LoanType> loanTypes) async {
    LoanApplicationAnalytics.loanApplicationSubmitButtonTapped();
    final success = await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => LoanConfirmationWidget(
        amount: _loanAmount!,
        durationDays: _selectedDurationInDays,
        loanType: loanTypes[_selectedLoanTypeIndex],
        purpose: _selectedPurpose!,
        selectedCurrency: loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex],
      ),
    );
    if (success ?? false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loan application submitted successfully'.tr()),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  void _loanApplicationListener() {
    final state = widget.provider.state;
    if (state is LoanTypesLoaded) {
      if (state.loanTypes.isNotEmpty) {
        final selectedLoan = state.loanTypes[_selectedLoanTypeIndex];
        if (selectedLoan.hasCurrencies) {
          _loanAmount =
              selectedLoan.currencies[_selectedCurrencyIndex].minLoanAmount;
        }
      }
    }
  }
}
