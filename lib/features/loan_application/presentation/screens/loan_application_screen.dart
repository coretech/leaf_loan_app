import 'package:flutter/material.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n_extension.dart';
import 'package:provider/provider.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({Key? key}) : super(key: key);
  static const String routeName = '/loan-application';

  @override
  _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  late LoanTypeProvider _loanTypeProvider;
  int _selectedCurrencyIndex = 0;
  int _selectedLoanTypeIndex = 0;
  int _selectedDurationInDays = 61;
  String? _selectedPurpose;
  double? _loanAmount;
  int currentStep = 0;

  final _remoteConfig = IntegrationIOC.remoteConfig();

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loanTypeProvider = LoanTypeProvider()
      ..getLoanTypes()
      ..addListener(_loanApplicationListener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanTypeProvider,
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                title: const Text(
                  'Apply for a loan',
                ),
              ),
              body: _buildContent(),
            );
          },
        );
      },
    );
  }

  Widget _buildContent() {
    if (_remoteConfig
            .getString(RemoteConfigKeys.formContentType)
            .toLowerCase() ==
        'a') {
      return FormContentA(
        hasLoanTypes: _hasLoanTypes(),
        loanAmount: _loanAmount,
        onCurrencySelected: _onCurrencySelected,
        onDurationInDaysSelected: _onDurationInDaysSelected,
        onLoanTypeSelected: _onLoanTypeSelected,
        onPurposeSelected: _onPurposeSelected,
        onSubmitPressed: _onSubmitPressed,
        selectedPurpose: _selectedPurpose,
        selectedCurrencyIndex: _selectedCurrencyIndex,
        selectedDurationInDays: _selectedDurationInDays,
        selectedLoanTypeIndex: _selectedLoanTypeIndex,
        onLoanAmountChanged: _onLoanAmountChanged,
      );
    } else if (_remoteConfig
            .getString(RemoteConfigKeys.formContentType)
            .toLowerCase() ==
        'b') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FormContentB(
                hasLoanTypes: _hasLoanTypes(),
                loanAmount: _loanAmount,
                onCurrencySelected: _onCurrencySelected,
                onDurationInDaysSelected: _onDurationInDaysSelected,
                onLoanTypeSelected: _onLoanTypeSelected,
                onPurposeSelected: _onPurposeSelected,
                onSubmitPressed: _onSubmitPressed,
                selectedPurpose: _selectedPurpose,
                selectedCurrencyIndex: _selectedCurrencyIndex,
                selectedDurationInDays: _selectedDurationInDays,
                selectedLoanTypeIndex: _selectedLoanTypeIndex,
                onLoanAmountChanged: _onLoanAmountChanged,
                controller: _pageController,
              ),
            ),
          ),
          StepIndicator(
            total: 5,
            controller: _pageController,
          ),
          NavButtons(
            pageController: _pageController,
            onSubmit: _onSubmitPressed,
            onNext: _onNext,
            onPrev: _onPrev,
          )
        ],
      );
    } else {
      return FormContentC(
        currentStep: currentStep,
        hasLoanTypes: _hasLoanTypes(),
        loanAmount: _loanAmount,
        selectedCurrencyIndex: _selectedCurrencyIndex,
        selectedLoanTypeIndex: _selectedLoanTypeIndex,
        selectedDurationInDays: _selectedDurationInDays,
        onPurposeSelected: _onPurposeSelected,
        onLoanAmountChanged: _onLoanAmountChanged,
        onLoanTypeSelected: _onLoanTypeSelected,
        onCurrencySelected: _onCurrencySelected,
        onDurationInDaysSelected: _onDurationInDaysSelected,
        onNextPressed: _onStepperNext,
        onBackPressed: _onOnStepperBack,
        onSubmitPressed: _onSubmitPressed,
      );
    }
  }

  void _onStepperNext() {
    setState(() {
      currentStep++;
    });
  }

  void _onOnStepperBack() {
    setState(() {
      currentStep--;
    });
  }

  void _onNext() {
    setState(() {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _onPrev() {
    setState(() {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
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

  void _onLoanTypeSelected(int value) {
    setState(() {
      _selectedCurrencyIndex = 0;
      _selectedLoanTypeIndex = value;
      _loanAmount = _loanTypeProvider
          .loanTypes[value].currencies[_selectedCurrencyIndex].minLoanAmount
          .toDouble();
    });
  }

  void _onCurrencySelected(int value) {
    setState(() {
      _selectedCurrencyIndex = value;
      _loanAmount = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
          .currencies[_selectedCurrencyIndex].minLoanAmount
          .toDouble();
    });
  }

  void _onDurationInDaysSelected(int durationInDays) {
    setState(() {
      _selectedDurationInDays = durationInDays;
    });
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onSubmitPressed() {
    if (_canSubmit()) {
      _onSubmit();
    } else {
      if (_loanAmount == null) {
        showSnackbar('Please select loan amount');
      } else if (_selectedPurpose == null) {
        showSnackbar('Please select loan purpose');
      } else if (_selectedDurationInDays < 61) {
        showSnackbar('Please select a proper loan duration');
      }
    }
  }

  bool _canSubmit() {
    return _loanTypeProvider.canShowTypes &&
        _loanAmount != null &&
        _selectedPurpose != null;
  }

  Future<void> _onSubmit() async {
    LoanApplicationAnalytics.loanApplicationSubmitButtonTapped();
    final success = await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => LoanConfirmationWidget(
        amount: _loanAmount!,
        durationDays: _selectedDurationInDays,
        loanType: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex],
        purpose: _selectedPurpose!,
        selectedCurrency: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex],
      ),
    );
    if (success) {
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

  bool _hasLoanTypes() {
    return _loanTypeProvider.loanTypes.isNotEmpty;
  }

  void _loanApplicationListener() {
    if (_loanTypeProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_loanTypeProvider.errorMessage!),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    if (_loanTypeProvider.loanTypes.isNotEmpty) {
      setState(() {
        _loanAmount = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex].minLoanAmount
            .toDouble();
      });
    }
  }
}
